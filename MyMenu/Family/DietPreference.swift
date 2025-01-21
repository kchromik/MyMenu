//
//  DietPreference.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import SwiftUI

enum Diet: String, CaseIterable {
    case omnivore
    case vegetarian
    case vegan
    case pescetarian
    
    func sfSymbol() -> String {
        switch self {
        case .omnivore:
            return "flame.fill"
        case .pescetarian:
            return "fish.fill"
        case .vegan:
            return "leaf.fill"
        case .vegetarian:
            return "apple.meditate"
        }
    }
}

struct DietPreference: View {
    
    @Binding var selectedDiet: Diet
    
    var body: some View {
        Text("Select your diet")
            .font(.headline)
        
        Picker("Diet Preference", selection: $selectedDiet) {
            
            ForEach(Diet.allCases, id: \.self) { diet in
                HStack {
                    Image(systemName: diet.sfSymbol())
                    Text(diet.rawValue.capitalized)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
}

#Preview {
    DietPreference(selectedDiet: .constant(.omnivore))
}
