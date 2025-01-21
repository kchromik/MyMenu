//
//  MenuAPI.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let image: String?
    let servings: Int?
    let readyInMinutes: Int?
    let cookingMinutes: Int?
    var extendedIngredients: [Ingredient]?
    let summary: String?
    let instructions: String?
    let vegetarian: Bool?
    let vegan: Bool?
    let glutenFree: Bool?
    
    func allIngredients() -> [String] {
        extendedIngredients?.compactMap { $0.name } ?? []
    }
}

struct Ingredient: Codable, Equatable, Hashable {
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.id == rhs.id
    }

    let id: Int?
    let name: String?
    var measures: Measures?
}

struct Measures: Codable, Hashable {
    var metric: MeasureMetric?
}

struct MeasureMetric: Codable, Hashable {
    var amount: Double?
    let unitShort: String?
    let unitLong: String?
}

import Foundation

struct RecipeInformation: Codable {
    
    // Basic Information
    let id: Int
    let title: String
    let image: String
    let sourceUrl: String?
    let readyInMinutes: Int?
    let servings: Int?
    let summary: String?
    
    // Dietary and Health Information
    let vegetarian: Bool?
    let vegan: Bool?
    let glutenFree: Bool?
    let dairyFree: Bool?
    let veryHealthy: Bool?
    let cheap: Bool?
    let veryPopular: Bool?
    let sustainable: Bool?
    let lowFodmap: Bool?
    let weightWatcherSmartPoints: Int?
    let healthScore: Int?
    
    // Ingredients
    let extendedIngredients: [Ingredient]
    
    struct Ingredient: Codable, Identifiable {
        let id: Int
        let image: String?
        let name: String?
        let amount: Double?
        let unit: String?
        let measures: Measures?
        
        struct Measures: Codable {
            let us: Measurement?
            let metric: Measurement?
            
            struct Measurement: Codable {
                let amount: Double?
                let unitShort: String?
                let unitLong: String?
            }
        }
    }
    
    // Instructions
    let instructions: String?
    let analyzedInstructions: [AnalyzedInstruction]
    
    struct AnalyzedInstruction: Codable {
        let name: String?
        let steps: [Step]
        
        struct Step: Codable {
            let number: Int?
            let step: String?
            let ingredients: [Ingredient]
            let equipment: [Equipment]
            let length: Length?
            
            struct Equipment: Codable {
                let id: Int
                let name: String?
                let localizedName: String?
                let image: String?
            }
            
            struct Length: Codable {
                let number: Int?
                let unit: String?
            }
        }
    }
}


class MenuAPI {
    
    func fetchRecipes(for diet: String) async throws -> [Recipe] {
//        let urlString = "https://api.spoonacular.com/recipes/complexSearch?\(diet)&number=7&addRecipeInformation=true&apiKey=\(APIToken.token)"
        
        let urlString = "https://api.spoonacular.com/recipes/random?number=7&apiKey=\(APIToken.token)"
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let stringData = String(decoding: data, as: UTF8.self)
        let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
        
        return response.recipes
    }
    
    func fetchRecipeDetails(recipeId: Int) async throws -> RecipeInformation {
        let urlString = "https://api.spoonacular.com/recipes/\(recipeId)/information?apiKey=\(APIToken.token)&includeNutrition=false&addRecipeInstructions=true"
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let stringData = String(decoding: data, as: UTF8.self)
        let recipeDetail = try JSONDecoder().decode(RecipeInformation.self, from: data)
        return recipeDetail
    }

    //    func generateWeeklyMenuForFamily(diets: [String]) -> String {
    //
    //
    //
    //
    //    }
}
