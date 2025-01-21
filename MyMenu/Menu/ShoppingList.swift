//
//  ShoppingList.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import SwiftUI

struct ShoppingList: View {
    
    let recipes: [Recipe]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(allIng(), id: \.self) { ing in
                    HStack {
                        Text(ing)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Shopping List")
        }
        
    }
    
    func allIng() -> [String] {
        var ing: [String] = []
        recipes.forEach { rec in
            ing.append(contentsOf: rec.allIngredients())
        }
        
        
        return Array(Set(ing))
    }
}

//#Preview {
//    ShoppingList()
//}
