//
//  ProductModel+CoreDataProperties.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 10.11.2023.
//
//

import Foundation
import CoreData


extension ProductModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductModel> {
        return NSFetchRequest<ProductModel>(entityName: "ProductModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var descriptionn: String?
    @NSManaged public var category: Int64
    @NSManaged public var image: String?
    @NSManaged public var quantity: Int64
    @NSManaged public var price: Int64

}

extension ProductModel : Identifiable {

}
