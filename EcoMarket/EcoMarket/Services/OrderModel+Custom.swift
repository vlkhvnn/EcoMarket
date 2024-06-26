//
//  OrderModel+Custom.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 10.11.2023.
//

import Foundation
import CoreData

extension OrderModel {
    var productsArray: [Product] {
        get {
            if let data = self.products,
               let decodedProducts = try? JSONDecoder().decode([Product].self, from: data as! Data) {
                return decodedProducts
            }
            return []
        }
        set {
            do {
                let encodedData = try JSONEncoder().encode(newValue)
                self.products = encodedData as NSObject?
            } catch {
                print("Error encoding products: \(error)")
            }
        }
    }
}

