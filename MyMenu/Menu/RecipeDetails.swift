//
//  RecipeDetails.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import WebKit
import SwiftUI


@Observable
class RecipeDetailsViewModel {
 
    var information: RecipeInformation? = nil
    
    func loadDetails(for id: Int) async {
        do {
            information = try await MenuAPI().fetchRecipeDetails(recipeId: id)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct RecipeDetails: View {
    
    @State var viewModel = RecipeDetailsViewModel()
    let recipe: Recipe

    var body: some View {
        ZStack {
            if let information = viewModel.information {
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: recipe.image ?? "")) { image in
                            ZStack {
                                image.resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 120)
                                    .clipped()
                                    .blur(radius: 2)
                                Text(viewModel.information?.title ?? "N/A")
                                    .font(.title).bold()
                                
                                    .foregroundStyle(Color.white)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .shadow(radius: 5)
                            }
                            .frame(height: 120)
                            
                        } placeholder: {
                            Color.gray
                                .frame(height: 120)
                        }
                        Spacer()
                        
                        
                        HStack {
                            Text("Ingredients")
                                .font(.title3)
                                .bold()
                                .padding()
                    
                            Spacer()
                        }
                        
                        ForEach(information.extendedIngredients, id: \.id) { ing in
                            HStack {
                                Text("• \(ing.name ?? "N/A")")
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await viewModel.loadDetails(for: recipe.id)
            }
        }
        
    }
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

//#Preview {
//
//    
//    RecipeDetails(recipe: Recipe(id: 1, title: "Pizza", image: "https://cdn.shopify.com/s/files/1/0274/9503/9079/files/20220211142754-margherita-9920_5a73220e-4a1a-4d33-b38f-26e98e3cd986.jpg?v=1723650067"))
//}
