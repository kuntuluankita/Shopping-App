//
//  FavoritesViewModel.swift
//  ShoppingApplication
//
//  Created by Kuntulu Ankita on 09/05/24.
//

import Foundation

class FavoritesViewModel {

    var categoryArray = MainProductViewModel.shared.categoryArray ?? []
    var favoriteArray: [Item]? = []
    
    func getFavoriteArray() -> [Item]? {
        favoriteArray = []
        for category in categoryArray {
            for item in category.items ?? []{
                if item.isFavorite {
                    favoriteArray?.append(item)
                }
            }
        }
        return favoriteArray
    }
}


