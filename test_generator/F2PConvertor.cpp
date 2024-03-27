#include "json.hpp"
#include "universal/include/universal/posit/posit.hpp"
#include <algorithm>
#include <fstream>
#include <iostream>
#include <map>
#include <string>

using json_t = nlohmann::json;

template <class T> struct tag { using type = T; };
template <class Tag> using type = typename Tag::type;
template <class T, size_t n>
struct n_dim_vec : tag<std::vector<type<n_dim_vec<T, n - 1>>>> {};
template <class T> struct n_dim_vec<T, 0> : tag<T> {};
template <class T, size_t n> using n_dim_vec_t = type<n_dim_vec<T, n>>;

json_t parse_data(std::string file_path) {
    std::ifstream file(file_path);
    json_t j;
    try {
        file >> j;
    } catch (nlohmann::detail::parse_error err) {
        std::cerr << err.what() << std::endl;
        exit(2);
    }
    return j;
}

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
void convert_path(json_t json, std::string field, int dim) {
    try {
        json_t transformed;
        transformed = json;
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
        std::cout << transformed.dump(2);
    } catch (nlohmann::json::type_error err) {
        std::cerr << "[Error] Expected `" << field
                  << ".data' field with type float[]" << std::endl;
        exit(2);
    }
}

void convert_to_posit(json_t json, std::string field, int posit_width,
                      int dim) {
    switch (posit_width) {
    case 16:
        convert_path<16, 1>(json, field, dim);
        break;
    case 32:
        convert_path<32, 2>(json, field, dim);
        break;
    case 64:
        convert_path<64, 3>(json, field, dim);
        break;
    case 128:
        convert_path<128, 4>(json, field, dim);
        break;

    default:
        std::cerr << "[Error] The supported posit standards are 16, 32 and 64"
                  << std::endl;
    }
}

int main(int argc, char *argv[]) {
    if (argc != 5) {
        std::cerr << "Usage: " << argv[0]
                  << "<json> <field> <dimension> <posit-width>\n"
                     "Converts a JSON file with floating points to posits \n";
        return 2;
    }
    auto json_file = parse_data(argv[1]);
    std::string field = argv[2];
    int dim = std::atoi(argv[3]);
    int width = std::atoi(argv[4]);

    convert_to_posit(json_file, field, width, dim);
}