//
//  Resources.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 16.02.2023.
//

import Foundation
import UIKit

enum Resources {
    enum Image {
        static let background = UIImage(named: "background")
        static let statistic = UIImage(named: "stat")
    }
    
    enum Color {
        static let appGreen = UIColor(red: 39/255, green: 237/255, blue: 130/255, alpha: 1)
        static let whiteClear = UIColor(white: 1, alpha: 0.8)
        static let lightGray = UIColor(red: 236/255, green: 246/255, blue: 236/255, alpha: 1)
        static let gray = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    }
    enum Fonts {
        static let drunkWaterFont = UIFont.systemFont(ofSize: 35, weight: .bold)
        static let needToDringWaterFont = UIFont.systemFont(ofSize: 17)
    }
}
