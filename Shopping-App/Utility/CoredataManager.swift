//
//  CoredataManager.swift
//  ShoppingApplication
//
//  Created by Kuntulu Ankita on 10/05/24.
//

import Foundation
import UIKit
import CoreData

final class CoredataManager {
    static let shared = CoredataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var coreDataCategoryArray: [Category] = []
    private init() { }
    
    func isDataLoadedInCoreData() -> Bool {
        let fetchRequest: NSFetchRequest<CategoryModel> = CategoryModel.fetchRequest()
        do {
            let categories = try context.fetch(fetchRequest)
            coreDataCategoryArray = mapCategoryModelsToCategories(categoryModels: categories)
            return !categories.isEmpty
        } catch {
            print("Error fetching categories: \(error)")
            return false
        }
    }
    
    func fetchCoreData() {
        let fetchRequest: NSFetchRequest<CategoryModel> = CategoryModel.fetchRequest()
        do {
            let categories = try context.fetch(fetchRequest)
            coreDataCategoryArray = mapCategoryModelsToCategories(categoryModels: categories)
        } catch {
            print("Error fetching categories: \(error)")
        }
    }
    
    func loadToCoreData(categoryArray: [Category]) {
        for item in categoryArray {
            let category = CategoryModel(context: context)
            category.id = Int64(item.id ?? 0)
            category.headerName = item.headerName
            category.isExpandable = item.isExpandable
            if let items = item.items {
                // Convert and add each ItemModel to the category
                for item in items {
                    let itemModel = ItemModel(context: context)
                    itemModel.id = Int64(item.id ?? 0)
                    itemModel.productName = item.productName
                    itemModel.icon = item.icon
                    itemModel.price = item.price ?? 0
                    itemModel.cartItemCount = Int64(item.cartItemCount)
                    itemModel.isFavorite = item.isFavorite
                    
                    // Add the item to the category's items set
                    category.addToItems(itemModel)
                }
            }
        }
        //If CategoryArray empty initially, assign the passed array
        if coreDataCategoryArray.isEmpty {
            coreDataCategoryArray = categoryArray
        }
        
        do {
            try context.save()
        } catch  {
            print("Error")
        }
    }
    
    func updateCoreDataCategories(with categoryArray: [Category]) {
        // Fetch existing CategoryModel objects
        let fetchRequest: NSFetchRequest<CategoryModel> = CategoryModel.fetchRequest()
        
        do {
            let existingCategories = try context.fetch(fetchRequest)
            
            // Iterate through the fetched categories and update them with new data
            for existingCategory in existingCategories {
                let categoryID = existingCategory.id
                if let updatedCategory = categoryArray.first(where: { $0.id == Int(categoryID) }) {
                    existingCategory.headerName = updatedCategory.headerName
                    existingCategory.isExpandable = updatedCategory.isExpandable
                    
                    // Remove existing items before adding updated items
                    if let items = existingCategory.items {
                        for item in items {
                            context.delete(item as! NSManagedObject)
                        }
                    }
                    
                    // Add updated items
                    if let updatedItems = updatedCategory.items {
                        for updatedItem in updatedItems {
                            let itemModel = ItemModel(context: context)
                            itemModel.id = Int64(updatedItem.id ?? 0)
                            itemModel.productName = updatedItem.productName
                            itemModel.icon = updatedItem.icon
                            itemModel.price = updatedItem.price ?? 0
                            itemModel.cartItemCount = Int64(updatedItem.cartItemCount)
                            itemModel.isFavorite = updatedItem.isFavorite
                            
                            existingCategory.addToItems(itemModel)
                        }
                    }
                }
            }
            
            // Save the changes
            try context.save()
        } catch {
            print("Error updating categories in Core Data: \(error)")
        }
    }

    
    func mapCategoryModelsToCategories(categoryModels: [CategoryModel]) -> [Category] {
        // Sort the category models by their IDs
        let sortedCategoryModels = categoryModels.sorted(by: { $0.id < $1.id })
        
        var categories: [Category] = []
        
        for categoryModel in sortedCategoryModels {
            var items: [Item] = []
            if let itemModels = categoryModel.items?.allObjects as? [ItemModel] {
                for itemModel in itemModels {
                    let item = Item(id: Int(itemModel.id),
                                    productName: itemModel.productName,
                                    icon: itemModel.icon,
                                    price: itemModel.price,
                                    cartItemCount: Int(itemModel.cartItemCount),
                                    isFavorite: itemModel.isFavorite)
                    items.append(item)
                }
            }
            
            let category = Category(id: Int(categoryModel.id),
                                    headerName: categoryModel.headerName,
                                    items: items,
                                    isExpandable: categoryModel.isExpandable)
            categories.append(category)
        }
        
        return categories
    }

}
