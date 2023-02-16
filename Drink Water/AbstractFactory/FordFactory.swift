//
//  FordFactory.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 16.02.2023.
//

import Foundation

class FordFactory: CarsFactory {
    func createSedan() -> Sedan {
        let ford = FordSedan()
        print("Create \(ford.name) \(ford.type)")
        return ford
    }
    
    func createCoupe() -> Coupe {
        let ford = FordCoupe()
        print("Create \(ford.name) \(ford.type)")
        return ford
    }
    
    
}
