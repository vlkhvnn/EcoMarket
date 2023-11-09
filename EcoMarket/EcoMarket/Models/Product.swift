//
//  Product.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 05.11.2023.
//

import Foundation

struct Product : Codable, Equatable {
    var id : Int
    var title : String
    var description : String
    var category : Int
    var image : String
    var quantity : Int
    var price : String
}
