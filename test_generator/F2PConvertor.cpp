#include "json.hpp"
#include "universal/include/universal/posit/posit.hpp"
#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <getopt.h>
#include <iostream>
#include <map>
#include <string>
#include <unistd.h>
#include <vector>

using json_t = nlohmann::json;

struct Input {
    json_t json;
    int posit_width;
    std::vector<std::string> one_dim_fields;
    std::vector<std::string> two_dim_fields;
};

template <class T> struct tag { using type = T; };
template <class Tag> using type = typename Tag::type;
template <class T, size_t n>
struct n_dim_vec : tag<std::vector<type<n_dim_vec<T, n - 1>>>> {};
template <class T> struct n_dim_vec<T, 0> : tag<T> {};
template <class T, size_t n> using n_dim_vec_t = type<n_dim_vec<T, n>>;

template <size_t nbits, size_t es>
void convert_float_to_posit(std::vector<double> &input,
                            std::vector<unsigned long> &output) {
    std::transform(input.cbegin(), input.cend(), output.begin(),
                   [](float v) -> unsigned long {
                       sw::unum::posit<nbits, es> p(v);
                       return p.get().to_ulong();
                   });
}

template <size_t nbits, size_t es>
void convert_path(json_t json, std::string field, int dim,
                  json_t &transformed) {
    try {
        switch (dim) {
        case 1: {
            auto data = json[field]["data"].get<n_dim_vec_t<double, 1>>();
            std::vector<unsigned long> data_posit(data.size());
            convert_float_to_posit<nbits, es>(data, data_posit);
            transformed[field]["data"] = data_posit;
        } break;
        case 2: {
            auto data = json[field]["data"].get<n_dim_vec_t<double, 2>>();
            std::vector<std::vector<unsigned long>> data_posit(
                data.size(), std::vector<unsigned long>(data[0].size(), 0));
            for (int i = 0; i < data.size(); i++) {
                convert_float_to_posit<nbits, es>(data[i], data_posit[i]);
            }
            transformed[field]["data"] = data_posit;
        } break;
        default:
            std::cerr << "[Error] The value of the dimension should be 1 or 2"
                      << std::endl;
        }
    } catch (nlohmann::json::type_error err) {
        std::cerr << "[Error] Expected `" << field
                  << ".data' field with type float[]" << std::endl;
        exit(2);
    }
}

void convert_to_posit(json_t json, std::string field, int posit_width, int dim,
                      json_t &transformed) {
    switch (posit_width) {
    case 8:
        convert_path<8, 1>(json, field, dim, transformed);
    case 16:
        convert_path<16, 1>(json, field, dim, transformed);
        break;
    case 32:
        convert_path<32, 2>(json, field, dim, transformed);
        break;
    case 64:
        convert_path<64, 3>(json, field, dim, transformed);
        break;
    case 128:
        convert_path<128, 4>(json, field, dim, transformed);
        break;

    default:
        std::cerr << "[Error] The supported posit standards are 16, 32 and 64"
                  << std::endl;
        exit(2);
    }
}

void split_strings(std::string input, char delimiter,
                   std::vector<std::string> &fields) {
    std::stringstream stream(input);
    std::string field;

    while (!stream.eof()) {
        std::getline(stream, field, delimiter);
        fields.push_back(field);
    }
}

void parse_data(int argc, char **argv, Input &input) {
    std::ifstream file(argv[1]);
    try {
        file >> input.json;
    } catch (nlohmann::detail::parse_error err) {
        std::cerr << err.what() << std::endl;
        exit(2);
    }

    input.posit_width = std::stoi(argv[2]);

    int c;
    int index;
    char *cvalue = NULL;
    while (1) {
        static struct option long_options[] = {
            {"1d", required_argument, 0, 'o'},
            {"2d", required_argument, 0, 't'},
            {"help", no_argument, 0, 'h'},
            {0, 0, 0, 0}};
        int option_index = 0;
        c = getopt_long(argc, argv, "o:t:h", long_options, &option_index);

        if (c == -1)
            break;

        switch (c) {
        case 'o':
            split_strings(optarg, ',', input.one_dim_fields);
            break;
        case 't':
            split_strings(optarg, ',', input.two_dim_fields);
            break;
        case '?':
            std::cerr << "Invalid option" << std::endl;
            exit(2);
        default:
            abort();
        }
    }
    if ((optind != argc - 2)) {
        std::cerr << "Invalid ARGV-elements" << std::endl;
        exit(2);
    }
}

int main(int argc, char *argv[]) {
    if (!(argc >= 5)) {
        std::cerr << "Usage: " << argv[0]
                  << "<json> <posit-width> --1d <one-dim field_1>,<one-dim "
                     "field_2> --2d <two-dim field_1>,<two-dim field_2>\n"
                     "Converts a JSON file with floating points to posits \n";
        return 2;
    }
    Input input;
    parse_data(argc, argv, input);
    json_t transformed = input.json;

    for (int i = 0; i < input.one_dim_fields.size(); i++) {
        convert_to_posit(input.json, input.one_dim_fields[i], input.posit_width,
                         1, transformed);
    }

    for (int i = 0; i < input.two_dim_fields.size(); i++) {
        convert_to_posit(input.json, input.two_dim_fields[i], input.posit_width,
                         2, transformed);
    }
    std::cout << transformed.dump(2);
}