//
//  ItemModel+CoreDataProperties.swift
//  Shopping-App
//
//  Created by Kuntulu Ankita on 10/05/24.
//
//

import Foundation
import CoreData


extension ItemModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemModel> {
        return NSFetchRequest<ItemModel>(entityName: "ItemModel")
    }

    @NSManaged public var cartItemCount: Int64
    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var isFavorite: Bool
    @NSManaged public var price: Double
    @NSManaged public var productName: String?
    @NSManaged public var category: CategoryModel?

}

extension ItemModel : Identifiable {

}
