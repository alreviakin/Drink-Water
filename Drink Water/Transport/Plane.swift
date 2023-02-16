//
//  Plane.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 16.02.2023.
//

import Foundation

class Plane: Transport {
    var name: String = "Plane"
    
    var speed: String = "200 kilometers per hour"
    
    func start() {
        print("Plane start")
    }
    
    func stop() {
        print("Plane stop")
    }
}
