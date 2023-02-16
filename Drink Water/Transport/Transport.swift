//
//  Transport.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 16.02.2023.
//

import Foundation

protocol Transport {
    var name: String {get}
    var speed: String {get}
    
    func start()
    func stop()
}
