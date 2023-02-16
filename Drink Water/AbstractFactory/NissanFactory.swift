//
//  NissanFactory.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 16.02.2023.
//

import Foundation

class NissanFactory: CarsFactory {
    func createSedan() -> Sedan {
        let nissan = NissanSedan()
        print("Create \(nissan.name) \(nissan.type)")
        return nissan
    }
    
    func createCoupe() -> Coupe {
        let nissan = NissanCoupe()
        print("Create \(nissan.name) \(nissan.type)")
        return nissan
    }
    
    
}
