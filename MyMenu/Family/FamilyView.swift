//
//  FamilyView.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import SwiftData
import SwiftUI

struct FamilyView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var family: [Person]
    
    @State private var showAddPerson: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(family) { person in
                        HStack {
                            
                            Image(systemName: Diet(rawValue: person.dietPreference)!.sfSymbol())
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Text(person.name)
                        }
                        .swipeActions {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                modelContext.delete(person)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Family")
            .toolbar {
                Button {
                    showAddPerson.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddPerson) {
                AddPersonView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    FamilyView()
}
