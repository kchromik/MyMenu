//
//  MyMenuApp.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import SwiftData
import SwiftUI

@main
struct MyMenuApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                FamilyView()
                    .tabItem {
                        Label("Family", systemImage: "person.3.fill")
                    }
                
                Menu()
                    .tabItem {
                        Label("Menu", systemImage: "fork.knife")
                    }
            }
        }
        .modelContainer(for: Person.self)
    }
}
