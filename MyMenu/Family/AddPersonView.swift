//
//  AddPersonView.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import SwiftUI

struct AddPersonView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var name: String = ""
    @State var dietPreference: Diet = .omnivore
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack() {
                Spacer()
                Text("Add Person")
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            
            TextField("Name", text: $name)
                .textFieldStyle(OutlinedTextFieldStyle())
                .padding()
            DietPreference(selectedDiet: $dietPreference)
                .padding()
            
            Spacer()
            
            Button("Add Person") {
                let person = Person(name: name, dietPreference: dietPreference)
                modelContext.insert(person)
                dismiss()
            }
            .disabled(name.isEmpty)
            .buttonStyle(BorderedButtonStyle())
            .frame(maxWidth: .infinity, minHeight: 44)
        }
        
    }
}

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
    }
}

#Preview {
    AddPersonView()
}
