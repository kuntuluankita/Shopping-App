//
//  CartViewModel.swift
//  ShoppingApplication
//
//  Created by Kuntulu Ankita on 09/05/24.
//

import Foundation

class CartViewModel {
    
    init() {
        cartArray = getCartArray()
    }

    var categoryArray = CoredataManager.shared.coreDataCategoryArray
    var cartArray: [Item]? = []
    
    func getCartArray() -> [Item]? {
        cartArray = []
        for category in categoryArray {
            for item in category.items ?? []{
                if item.cartItemCount > 0 {
                    cartArray?.append(item)
                }
            }
        }
        return cartArray
    }
    
    func calculateTotalPrice() -> Double {
        guard let cartArray = self.cartArray else { return 0.0 }
        var total = 0.0
        for cart in cartArray {
            total += (cart.price ?? 0.0) * Double(cart.cartItemCount)
        }
        return total
    }
    
}
