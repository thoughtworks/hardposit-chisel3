#include "json.hpp"
#include "universal/include/universal/posit/posit.hpp"
#include <algorithm>
#include <fstream>
#include <getopt.h>
#include <iostream>
#include <map>
#include <string>
#include <unistd.h>
#include <vector>

using json_t = nlohmann::json;

struct Args {
    json_t json;
    int posit_width;
    std::vector<std::string> one_dim_fields;
    std::vector<std::string> two_dim_fields;
    Args() = delete;
};

const static struct option long_options[] = {{"1d", required_argument, 0, 'o'},
                                             {"2d", required_argument, 0, 't'},
                                             {0, 0, 0, 0}};

template <class T> struct tag { using type = T; };
template <class Tag> using type = typename Tag::type;
template <class T, size_t n>
struct n_dim_vec : tag<std::vector<type<n_dim_vec<T, n - 1>>>> {};
template <class T> struct n_dim_vec<T, 0> : tag<T> {};
template <class T, size_t n> using n_dim_vec_t = type<n_dim_vec<T, n>>;

void print_usage(std::string command) {
    std::cerr << "Usage: \n\t" << command
              << " <json> <posit-width> --1d <one-dim field_1>,<one-dim "
                 "field_2> --2d <two-dim field_1>,<two-dim field_2>\n\t"
                 "Converts a JSON file with posits to floating floats \n";
}

template <size_t nbits, size_t es>
void convert_posit_to_float(std::vector<unsigned long> &input,
                            std::vector<double> &output) {
    std::transform(input.cbegin(), input.cend(), output.begin(),
                   [](unsigned long v) -> double {
                       sw::unum::posit<nbits, es> p;
                       p.set_raw_bits(v);
                       return (double)p;
                   });
}

template <size_t nbits, size_t es>
void convert_path(json_t json, std::string field, int dim,
                  json_t &transformed) {
    try {
        switch (dim) {
        case 1: {
            auto data =
                json["memories"][field].get<n_dim_vec_t<unsigned long, 1>>();
            std::vector<double> data_float(data.size());
            convert_posit_to_float<nbits, es>(data, data_float);
            transformed["memories"][field] = data_float;
        } break;
        case 2: {
            auto data =
                json["memories"][field].get<n_dim_vec_t<unsigned long, 2>>();
            std::vector<std::vector<double>> data_float(
                data.size(), std::vector<double>(data[0].size(), 0));
            for (int i = 0; i < data.size(); i++) {
                convert_posit_to_float<nbits, es>(data[i], data_float[i]);
            }
            transformed["memories"][field] = data_float;
        } break;
        default:
            std::cerr << "[Error] The value of the dimension should be 1 or 2"
                      << std::endl;
        }
    } catch (nlohmann::json::type_error err) {
        std::cerr << "[Error] Expected `memories." << field
                  << "` field with type posit[]" << std::endl;
        exit(2);
    }
}

void convert_to_float(json_t json, std::string field, int posit_width, int dim,
                      json_t &transformed) {
    switch (posit_width) {
    case 8:
        convert_path<8, 1>(json, field, dim, transformed);
        break;
    case 16:
        convert_path<16, 1>(json, field, dim, transformed);
        break;
    case 32:
        convert_path<32, 2>(json, field, dim, transformed);
        break;
    case 64:
        convert_path<64, 3>(json, field, dim, transformed);
        break;
    // TODO: Currently 128 bit is not supported as we are using unsigned long.
    // case 128:
    //     convert_path<128, 4>(json, field, dim, transformed);
    //     break;
    default:
        std::cerr
            << "[Error] The supported posit standards are 8, 16, 32 and 64"
            << std::endl;
        exit(2);
    }
}

std::vector<std::string> split_strings(const std::string &input,
                                       char delimiter) {
    std::vector<std::string> fields;
    std::stringstream stream(input);
    std::string field;

    while (!stream.eof()) {
        std::getline(stream, field, delimiter);
        fields.push_back(field);
    }
    return fields;
}

Args parse_data(int argc, char **argv) {
    json_t json;
    std::ifstream file(argv[1]);
    try {
        file >> json;
    } catch (nlohmann::detail::parse_error err) {
        std::cerr << err.what() << std::endl;
        exit(2);
    }

    int posit_width = std::stoi(argv[2]);

    int c, option_index;
    std::vector<std::string> one_dim_fields, two_dim_fields, split;
    while ((c = getopt_long(argc, argv, ":o:t:", long_options,
                            &option_index)) != -1) {
        switch (c) {
        case 'o':
            split = split_strings(optarg, ',');
            one_dim_fields.insert(one_dim_fields.end(), split.begin(),
                                  split.end());
            break;
        case 't':
            split = split_strings(optarg, ',');
            two_dim_fields.insert(two_dim_fields.end(), split.begin(),
                                  split.end());
            break;
        case '?':
            std::cerr << "Invalid option" << std::endl;
            print_usage(argv[0]);
            exit(2);
        default:
            std::cerr << "Unexpected behaviour" << std::endl;
            print_usage(argv[0]);
            exit(2);
        }
    }
    if ((optind != argc - 2)) {
        std::cerr << "Invalid arguments" << std::endl;
        exit(2);
    }
    return Args{json, posit_width, one_dim_fields, two_dim_fields};
}

int main(int argc, char *argv[]) {
    if (!(argc >= 5)) {
        print_usage(argv[0]);
        return 2;
    }
    Args input = parse_data(argc, argv);
    json_t transformed = input.json;

    for (int i = 0; i < input.one_dim_fields.size(); i++) {
        convert_to_float(input.json, input.one_dim_fields[i], input.posit_width,
                         1, transformed);
    }

    for (int i = 0; i < input.two_dim_fields.size(); i++) {
        convert_to_float(input.json, input.two_dim_fields[i], input.posit_width,
                         2, transformed);
    }
    std::cout << transformed.dump(2);
}