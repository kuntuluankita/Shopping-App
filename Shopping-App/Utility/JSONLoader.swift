//
//  JSONLoader.swift
//  Shopping app
//
//  Created by Kuntulu Ankita on 08/05/24.
//

import Foundation

final class MainProductViewModel {
    static let shared = MainProductViewModel()
    var categoryArray: [Category]? = []
    private init() {}
}

class JSONLoader {
   static func loadJSONData() {
        guard let url = Bundle.main.url(forResource: "shopping", withExtension: "json") else {
            print("File not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let shoppingModel = try JSONDecoder().decode(ShoppingModel.self, from: data)
            
            //Assigning to Singleton Class
            MainProductViewModel.shared.categoryArray = shoppingModel.categories

        } catch  {
            print("decoding error")
        }
    }
}
