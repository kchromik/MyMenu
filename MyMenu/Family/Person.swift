//
//  Person.swift
//  MyMenu
//
//  Created by Kevin Chromik on 21.01.25.
//

import SwiftData

@Model
class Person {
    
    var name: String
    var dietPreference: String
    
    init(name: String, dietPreference: Diet) {
        self.name = name
        self.dietPreference = dietPreference.rawValue
    }
}
