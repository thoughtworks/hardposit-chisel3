#include <fstream>
#include <iostream>
#include <string>
#include <algorithm>

#include "universal/include/universal/posit/posit.hpp"
#include "json.hpp"

using json_t = nlohmann::json;

json_t parse_data(int argc, char** argv) {
    if (argc != 4) {
        std::cout << "Usage: PositConvertor <json> <json-path> <dimension> \n"
                 "Converts a JSON file with floating point numbers to posits\n";
        exit(2);
    }
    std::ifstream file(argv[1]);
    json_t j;
    try {
        file >> j;
    } catch (nlohmann::detail::parse_error err) {
        std::cerr << err.what() << std::endl;
        exit(2);
    }
    return j;
}

template<class T>struct tag{using type=T;};
template<class Tag>using type=typename Tag::type;

template<class T, size_t n>
    struct n_dim_vec:tag< std::vector< type< n_dim_vec<T, n-1> > > > {};
  template<class T>
    struct n_dim_vec<T, 0>:tag<T>{};
  template<class T, size_t n>
    using n_dim_vec_t = type<n_dim_vec<T,n>>;

void convert_path_1d(json_t json, std::string field) {
    try {
        auto data = json[field]["data"].get<n_dim_vec_t<double, 1>>();
        std::vector<unsigned long> data_posit(data.size());
        std::transform(
            data.cbegin(),
            data.cend(),
            data_posit.begin(),
            [](double v) -> unsigned long {
                sw::unum::posit <32, 2> p (v);
                return p.get().to_ulong();
        });
        json_t transformed;
        transformed = json;
        transformed[field]["data"] = data_posit;
        std::cout << transformed.dump(2);
    }  catch(nlohmann::json::type_error err) {
        std::cerr << "[Error] Expected `" << field << ".data' field with type float[]" << std::endl;
        exit(2);
    }
}

 void convert_path_2d(json_t json, std::string field) {
     try {
             auto data = json[field]["data"].get<n_dim_vec_t<float, 2>>();
             std::vector<std::vector<unsigned long>> data_posit(data.size(), std::vector<unsigned long>(data[0].size(), 0));
             for( int i = 0; i < data.size() ; i++) {
                 std::transform(
                     data[i].cbegin(),
                     data[i].cend(),
                     data_posit[i].begin(),
                     [](float v) -> unsigned long {
                         sw::unum::posit <32, 2> p (v);
                         return p.get().to_ulong();
                 });
              }
             json_t transformed;
             transformed = json;
             transformed[field]["data"] = data_posit;
             std::cout << transformed.dump(2);
         }  catch(nlohmann::json::type_error err) {
             std::cerr << "[Error] Expected `" << field << ".data' field with type float[]" << std::endl;
             exit(2);
         }
    }

int main(int argc, char *argv[]) {
    auto j = parse_data(argc, argv);
    switch(argv[3][0]) {
    case '1':
    convert_path_1d(j, argv[2]);
    break;
    case '2':
    convert_path_2d(j, argv[2]);
    break;
    default:
    std::cout << "Usage: PositConvertor <json> <json-path> <dimension> \n"
                    "Dimension of the array should be either 1 or 2 \n";
            exit(2);
    }
}
