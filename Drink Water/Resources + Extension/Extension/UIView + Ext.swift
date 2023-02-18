//
//  UIView + Ext.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 17.02.2023.
//
import UIKit

extension UIView {
    func moveInTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.moveIn
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
