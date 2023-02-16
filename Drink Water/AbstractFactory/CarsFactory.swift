//
//  AbstractFactory.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 16.02.2023.
//

import Foundation

protocol CarsFactory {
    func createSedan() -> Sedan
    func createCoupe() -> Coupe
}
