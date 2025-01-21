//
//  MenuCell.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import SwiftUI

struct MenuCell: View {
    
    let recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.image ?? "")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
            } placeholder: {
                Color.gray
                    .frame(width: 80, height: 80)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Text(recipe.title)
                .padding()
            Spacer()
        }
    }
}

//#Preview {
//    MenuCell(recipe: Recipe(id: 1, title: "Pizza", image: "https://cdn.shopify.com/s/files/1/0274/9503/9079/files/20220211142754-margherita-9920_5a73220e-4a1a-4d33-b38f-26e98e3cd986.jpg?v=1723650067"))
//}
