//
//  Menu.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import SwiftData
import SwiftUI

@Observable
class MenuViewModel {
    
    var isLoading = false
    var mealPlan: [Recipe] = []
    
    func loadMenu(for family: [Person]) async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        let dietPreferences = family.map { $0.dietPreference }.first!
        
        do {
            mealPlan = try await MenuAPI().fetchRecipes(for: dietPreferences)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadRecipeDetails(for id: Int) async throws -> RecipeInformation {
        return try await MenuAPI().fetchRecipeDetails(recipeId: id)
    }
}

struct Menu: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var showShoppingList: Bool = false

    @State var viewModel: MenuViewModel = MenuViewModel()
    @Query private var family: [Person]
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.mealPlan.isEmpty {
                    Button("Create Menu") {
                        Task {
                            await viewModel.loadMenu(for: family)
                        }
                    }
                } else {
                    List {
                        ForEach(viewModel.mealPlan, id: \.id) { recipe in
                            NavigationLink {
                                RecipeDetails(recipe: recipe)
                            } label: {
                                MenuCell(recipe: recipe)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Menu")
            .toolbar {
                Button {
                    showShoppingList.toggle()
                } label: {
                    Image(systemName: "list.bullet")
                }
            }
            .sheet(isPresented: $showShoppingList) {
                ShoppingList(recipes: viewModel.mealPlan)
            }
        }
    }
}

#Preview {
    Menu(viewModel: MenuViewModel())
}
