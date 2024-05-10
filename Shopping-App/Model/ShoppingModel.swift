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
}
