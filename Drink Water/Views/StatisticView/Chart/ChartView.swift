//
//  ChartView.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 19.02.2023.
//

import UIKit
import Charts


final class ChartView: UIView {
    private let chart = LineChartView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        let lineChartEntries = [
            ChartDataEntry(x: 1, y: 2),
            ChartDataEntry(x: 2, y: 4),
            ChartDataEntry(x: 3, y: 3),
        ]
        let dataSet = LineChartDataSet(entries: lineChartEntries)
        dataSet.mode = .cubicBezier
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.drawFilledEnabled = true
        dataSet.lineWidth = 5
        dataSet.setColor(NSUIColor(cgColor: Resources.Color.appGreen.cgColor), alpha: 1)
        let colors = [
            Resources.Color.appGreen.withAlphaComponent(1).cgColor,
            Resources.Color.appGreen.withAlphaComponent(0.1).cgColor
        ] as CFArray
        let locations: [CGFloat] = [0.6,1]
        if let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: colors,
            locations: locations
        ) {
            dataSet.fill = LinearGradientFill(gradient: gradient,angle: 270)
        }
        
        let data = LineChartData(dataSet: dataSet)
        chart.data = data
        addSubview(chart)
        // отключаем координатную сетку
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.drawGridBackgroundEnabled = false
        // отключаем легенду
        chart.legend.enabled = false
        // отключаем зум
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        // убираем артефакты вокруг области графика
        chart.xAxis.enabled = false
        chart.leftAxis.drawAxisLineEnabled = false
        chart.leftAxis.labelXOffset = 40
        chart.extraLeftOffset = -30
        chart.rightAxis.enabled = false
        chart.drawBordersEnabled = false
        chart.minOffset = 0
        layout()
    }
    
    private func layout() {
        chart.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

