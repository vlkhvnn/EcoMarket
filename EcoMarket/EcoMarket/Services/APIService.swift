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
}
