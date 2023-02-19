//
//  ProgressView.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 19.02.2023.
//

import UIKit


final class ProgressView: UIView {
    func drawProgress(with percent: CGFloat, width: CGFloat) {
        layer.sublayers?.removeAll()
        
        //MARK: - Background circle
        let radius = (width - width * 0.3) / 2
        let center = CGPoint(x: width / 2, y: width / 2)
        let startAngel = -CGFloat.pi * 1 / 2
        let endAngel = CGFloat.pi * 3 / 2
        
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: startAngel,
                                      endAngle: endAngel,
                                      clockwise: true)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = Resources.Color.lightGray.cgColor
        
        circleLayer.lineWidth = 40
        circleLayer.strokeEnd = 1
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineCap = .round
        
        //MARK: - bars
        let barsPath = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: startAngel,
                                    endAngle: endAngel,
                                    clockwise: true)
        
        let barsLayer = CAShapeLayer()
        barsLayer.path = barsPath.cgPath
        barsLayer.strokeColor = UIColor.clear.cgColor
        barsLayer.fillColor = UIColor.clear.cgColor
        barsLayer.lineWidth = 12
        
        let startBarRadius = radius - barsLayer.lineWidth / 2
        let startBigBarRadius = radius - barsLayer.lineWidth + 2
        let endBarRadius = startBarRadius + barsLayer.lineWidth
        let endBigBarRadius = startBarRadius + barsLayer.lineWidth * 2 - 6
        var angle: CGFloat =  -1/2
        var angleMorePercentAngel: Bool = true
        let angelPercent = -1/2 + (2 * percent)
        
        (1...60).forEach { num in
            angleMorePercentAngel = angle <= angelPercent
            let barAngle = CGFloat.pi * angle
            var startBarPoint = CGPoint()
            var endBarPoint = CGPoint()
            if num == 1 || (angelPercent - angle) < 1/30 &&  (angelPercent - angle) > 0 {
                startBarPoint = CGPoint(
                    x: cos(barAngle) * startBigBarRadius + center.x,
                    y: sin(barAngle) * startBigBarRadius + center.y
                )
                endBarPoint = CGPoint(
                    x: cos(barAngle) * endBigBarRadius + center.x,
                    y: sin(barAngle) * endBigBarRadius + center.y
                )
            } else {
                startBarPoint = CGPoint(
                    x: cos(barAngle) * startBarRadius + center.x,
                    y: sin(barAngle) * startBarRadius + center.y
                )
                endBarPoint = CGPoint(
                    x: cos(barAngle) * endBarRadius + center.x,
                    y: sin(barAngle) * endBarRadius + center.y
                )
            }
            
            let barPath = UIBezierPath()
            barPath.move(to: startBarPoint)
            barPath.addLine(to: endBarPoint)
            
            let barLayer = CAShapeLayer()
            barLayer.path = barPath.cgPath
            barLayer.fillColor = UIColor.clear.cgColor
            barLayer.strokeColor = angleMorePercentAngel ? Resources.Color.appGreen.cgColor : Resources.Color.gray.cgColor
            barLayer.lineCap = .round
            barLayer.lineWidth = num == 1 || (angelPercent - angle) < 1/30 &&  (angelPercent - angle) > 0 ? 5 : 3
            
            barsLayer.addSublayer(barLayer)
            angle += 1/30
        }
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(barsLayer)
    }
}
