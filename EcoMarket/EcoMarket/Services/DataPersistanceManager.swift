//
//  DataPersistanceManager.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 10.11.2023.
//

import UIKit
import CoreData

class DataPersistanceManager {
    
    enum DatabaseError : Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistanceManager()
    
    func downloadOrder(_ model: Order, completion: @escaping(Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = OrderModel(context: context)
        
        item.order_number = Int64(model.order_number)
        item.phone_number = model.phone_number
        item.address = model.address
        item.reference_point = model.reference_point
        item.comments = model.comments
        item.total_amount = Int64(model.total_amount)
        item.created_at = model.created_at
        
        do {
            let encodedProducts = try JSONEncoder().encode(model.products)
            item.products = encodedProducts as NSObject?
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
            return
        }
        
        do {
            try context.save()
            completion(.success(()))
        }
        catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchingOrdersFromDatabase(completion: @escaping (Result<[OrderModel], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<OrderModel>
        
        request = OrderModel.fetchRequest()
        
        do {
            let orders = try context.fetch(request)
            completion(.success(orders))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
}
