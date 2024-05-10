//
//  ShoppingModel.swift
//  Shopping app
//
//  Created by Kuntulu Ankita on 08/05/24.
//

import Foundation

// MARK: - ShoppingModel
class ShoppingModel: Codable {
    let status: Bool?
    let message: String?
    let categories: [Category]?
}

// MARK: - Category
class Category: Codable {
    let id: Int?
    let headerName: String?
    var items: [Item]?
    var isExpandable: Bool = true
    
    enum CodingKeys: String, CodingKey {
        case id, items
        case headerName = "name"
    }
    
    init(id: Int?, headerName: String?, items: [Item]? = nil, isExpandable: Bool) {
        self.id = id
        self.headerName = headerName
        self.items = items
        self.isExpandable = isExpandable
    }
}

// MARK: - Item
class Item: Codable {
    var id: Int?
    var productName: String?
    var icon: String?
    var price: Double?
    var cartItemCount: Int = 0
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, icon, price
        case productName = "name"
    }
    
    init(id: Int? = nil, productName: String? = nil, icon: String? = nil, price: Double? = nil, cartItemCount: Int, isFavorite: Bool) {
        self.id = id
        self.productName = productName
        self.icon = icon
        self.price = price
        self.cartItemCount = cartItemCount
        self.isFavorite = isFavorite
    }
}
