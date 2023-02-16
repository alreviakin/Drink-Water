//
//  Ship.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 16.02.2023.
//

import Foundation

class Ship: Transport {
    var name: String = "Ship"
    
    var speed: String = "60 kilometers per hour"
    
    func start() {
        print("Ship start")
    }
    
    func stop() {
        print("Ship stop")
    }
}
