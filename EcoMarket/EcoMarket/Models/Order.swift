//
//  Order.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 06.11.2023.
//

import Foundation

struct Order : Codable {
    var order_number : Int
    var products : [Product]
    var phone_number : String
    var address : String
    var reference_point : String
    var comments : String
    var total_amount : Int
    var created_at : Date
}
