//
//  CategoryModel+CoreDataProperties.swift
//  Shopping-App
//
//  Created by Kuntulu Ankita on 10/05/24.
//
//

import Foundation
import CoreData


extension CategoryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryModel> {
        return NSFetchRequest<CategoryModel>(entityName: "CategoryModel")
    }

    @NSManaged public var headerName: String?
    @NSManaged public var id: Int64
    @NSManaged public var isExpandable: Bool
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension CategoryModel {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ItemModel)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ItemModel)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension CategoryModel : Identifiable {

}
