//
//  ServerService.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 05.11.2023.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    
    func fetchProductCategory(handler: @escaping ([ProductCategory]) -> Void) {
        let url = "https://neobook.online/ecobak/product-category-list/"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    if let responseData = data {
                        do {
                            let jsonData = try JSONDecoder().decode([ProductCategory].self, from: responseData)
                            handler(jsonData)
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        print("No data received")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchAllProducts(handler: @escaping ([Product]) -> Void) {
        let url = "https://neobook.online/ecobak/product-list/"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    if let responseData = data {
                        do {
                            let jsonData = try JSONDecoder().decode([Product].self, from: responseData)
                            handler(jsonData)
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        print("No data received")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchSearchingProducts(categoryName: String?, searchString: String?, handler: @escaping ([Product]) -> Void) {
        let url = "https://neobook.online/ecobak/product-list/"
        
        var parameters: [String: String] = [:]

        if let category = categoryName {
            parameters["category_name"] = category
        }

        if let search = searchString {
            parameters["search"] = search
        }

        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    if let responseData = data {
                        do {
                            let jsonData = try JSONDecoder().decode([Product].self, from: responseData)
                            handler(jsonData)
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        print("No data received")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

}
