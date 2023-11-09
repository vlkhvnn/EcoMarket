//
//  CartService.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 08.11.2023.
//

import Foundation

class CartService {
    
    static let shared = CartService()
    
    private var cartItems = [Product]()
    
    func getCartItems() -> [Product] {
        return cartItems
    }
    
    func addToCart(item: Product) {
        cartItems.append(item)
    }
    
    func addQuantity(_ item : Product) {
        if cartItems[indexOfProductInCart(item)!].quantity >= 50 {
            return
        }
        cartItems[indexOfProductInCart(item)!].quantity += 1
    }
    
    func minusQuantity(_ item : Product) {
        if cartItems[indexOfProductInCart(item)!].quantity == 1 {
            removeFromCart(item: item)
            return
        }
        cartItems[indexOfProductInCart(item)!].quantity -= 1
    }

        // Function to remove an item from the cart
    func removeFromCart(item: Product) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems.remove(at: index)
    
        }
    }
    
    func isProductInCart(product: Product) -> Bool {
        return cartItems.contains(where: { $0 == product })
    }
    
    func indexOfProductInCart(_ product: Product) -> Int? {
        // Find the index of the product in the cartItems array
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            return index
        }
        return nil
    }
    
    func calculateTotalSumma() -> Int {
        var summa : Int = 0
        for product in cartItems {
            if let price = Double(product.price) {
                summa += product.quantity * Int(price)
            }
        }
        return summa
    }
}
