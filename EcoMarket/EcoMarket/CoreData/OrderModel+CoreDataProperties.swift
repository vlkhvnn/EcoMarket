//
//  OrderModel+CoreDataProperties.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 10.11.2023.
//
//

import Foundation
import CoreData


extension OrderModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderModel> {
        return NSFetchRequest<OrderModel>(entityName: "OrderModel")
    }

    @NSManaged public var products: [Product]?
    @NSManaged public var order_number: Int64
    @NSManaged public var phone_number: String?
    @NSManaged public var address: String?
    @NSManaged public var reference_point: String?
    @NSManaged public var comments: String?
    @NSManaged public var total_amount: Int64
    @NSManaged public var created_at: Date?

}

extension OrderModel : Identifiable {

}
