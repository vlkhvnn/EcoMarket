//
//  ServerService.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 05.11.2023.
//

import Foundation
import Alamofire

enum URLs : String {
    case categories = "https://neobook.online/ecobak/product-category-list/"
    case products = "https://neobook.online/ecobak/product-list/"
}

final class APIService {
    static let shared = APIService()
    
    func fetchData<T: Codable>(from url : String, handler: @escaping ([T]) -> Void) {
        AF.request(url,method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    if let responseData = data {
                        do {
                            let jsonData = try JSONDecoder().decode([T].self, from: responseData)
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
    
    func fetchSearching<T: Codable>(categoryName: String?, searchString: String?, handler: @escaping ([T]) -> Void) {
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
                            let jsonData = try JSONDecoder().decode([T].self, from: responseData)
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
