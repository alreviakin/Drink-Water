//
//  StatisticView.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 18.02.2023.
//

import UIKit
import SnapKit
import Charts

enum DayInterval: String {
    case Today
    case Yesterday
    case Week
    case Month
}

class StatisticView: UIViewController {
    private var drinksData: [String: Int] = [:]
    private var currentViewDrinkData: [String: Int] = [:]
    private var offset: CGFloat! = nil
    private var amount = 0
    private var target: Float = 0
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Image.background
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Drink Report"
        label.textColor = Resources.Color.whiteClear
        return label
    }()
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        return button
    }()
    private var menuItems: [UIAction] = []
    private var menu = UIMenu()
    private let dayButton: UIButton = {
        let buton = UIButton()
        buton.setTitle("Today", for: .normal)
        buton.tintColor = .white
        buton.titleLabel?.font = Resources.Fonts.drunkWaterFont
        buton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        buton.titleLabel?.textAlignment = .left
        return buton
    }()
    private let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.96)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    private let progress = ProgressView()
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Color.appGreen
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()
    private var percent: Float = 100
    private let labelNameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    private let labelNumberStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    private var chart = ChartView(frame: CGRect())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offset = (view.bounds.width * 0.1).rounded()
        initialize(titleDayButton: "Today", chartEntries: getChartEntries(interval: .Today))
        layout()
    }
    
    private func initialize(titleDayButton: String, chartEntries: [ChartDataEntry]) {
        for subview in view.subviews as [UIView]   {
          subview.removeFromSuperview()
        }
        for view in labelNameStackView.subviews {
            view.removeFromSuperview()
        }
        for view in labelNumberStackView.subviews {
            view.removeFromSuperview()
        }
        dayButton.setTitle(titleDayButton, for: .normal)
        
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(backButton)
        menuItems = [
            UIAction(title: "Today", handler: { [self] action in
                initialize(titleDayButton: "Today", chartEntries: self.getChartEntries(interval: .Today))
                layout()
            }),
            UIAction(title: "Yesterday", handler: { [self] action in
                initialize(titleDayButton: "Yesterday", chartEntries: self.getChartEntries(interval: .Yesterday))
                layout()
            }),
            UIAction(title: "Week", handler: {[self] action in
                initialize(titleDayButton: "Week", chartEntries: self.getChartEntries(interval: .Week))
                layout()
            }),
            UIAction(title: "Month", handler: { [self] action in
                initialize(titleDayButton: "Month", chartEntries: self.getChartEntries(interval: .Month))
                layout()
            })
        ]
        menu = UIMenu(children: menuItems)
        dayButton.menu = menu
        dayButton.showsMenuAsPrimaryAction = true
        view.addSubview(dayButton)
        view.addSubview(transparentView)
        progress.drawProgress(with: CGFloat(percent), width: view.bounds.width - offset * 2)
        transparentView.addSubview(progress)
        percentLabel.text = "\((percent * 100).rounded() <= 100 ? (percent * 100).rounded() : 100)%"
        progress.addSubview(percentLabel)
        addStack(stack: labelNameStackView, arr: [createNameLabel(with: "Remainig"), createNameLabel(with: "Target")])
        addStack(stack: labelNumberStackView, arr: [createNumberLabel(with: (Int(target) - amount >= 0 ? Int(target) - amount : 0)), createNumberLabel(with: Int(target))])
        chart.configureLineChartLize(lineChartEntries: chartEntries)
        view.addSubview(chart)
    }
    
    private func addStack(stack: UIStackView, arr: [UILabel]) {
        for i in arr {
            stack.addArrangedSubview(i)
        }
        transparentView.addSubview(stack)
    }
    
}

extension StatisticView {
    private func layout() {
        backgroundImageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.remakeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(view.bounds.width * 0.1)
            make.top.equalToSuperview().offset(view.bounds.width * 0.15)
            make.height.equalTo(30)
        }
        backButton.snp.remakeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(titleLabel.snp.left)
            make.height.equalTo(titleLabel.snp.height)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        dayButtonLayout()
        transparentView.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(offset)
            make.right.equalToSuperview().offset(-offset)
            make.top.equalTo(dayButton.snp.bottom).offset(offset)
            make.height.equalTo(view.bounds.height * 0.45)
        }
        progress.snp.remakeConstraints { make in
            make.centerX.top.equalToSuperview()
            make.width.height.equalTo(transparentView.snp.width)
        }
        percentLabel.snp.remakeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        labelNameStackView.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(progress.snp.bottom)
            make.height.equalTo(15)
        }
        labelNumberStackView.snp.remakeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(labelNameStackView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        chartLayout()
    }
}

extension StatisticView {
    private func chartLayout() {
        chart.snp.remakeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(transparentView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
    private func dayButtonLayout() {
        dayButton.snp.remakeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(40)
        }
        dayButton.imageView?.snp.remakeConstraints { make in
            make.left.equalToSuperview()
        }
        dayButton.titleLabel?.snp.remakeConstraints({ make in
            make.left.equalTo(dayButton.imageView!.snp.right)
        })
    }
}

extension StatisticView {
    func configView(drinksData: [String: Int]) {
        self.drinksData = drinksData
    }
}

extension StatisticView {
    private func createNameLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }
    
    private func createNumberLabel(with num: Int) -> UILabel {
        let label = UILabel()
        label.text = "\(num) ml"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }
    
    private func getDate(interval: DayInterval) -> String {
        let today = Calendar.current.startOfDay(for: .now)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy:MM:dd"
        
        switch interval {
        case .Today:
            return dateFormater.string(from: today)
        case .Yesterday:
            return dateFormater.string(from: today - (60*60*24))
        case .Week:
            return dateFormater.string(from: today - (60*60*24*7))
        case .Month:
            return dateFormater.string(from: today - (60*60*24*30))
        }
    }
    
    private func getChartEntries(interval: DayInterval) -> [ChartDataEntry] {
        amount = 0
        switch interval{
        case .Today:
            let day = getDate(interval: .Today)
            var dayData: [String: Int] = [:]
            drinksData.forEach { key, value in
                if key.hasPrefix(day) {
                    dayData[String(key.split(separator: " ")[1])] = value
                }
            }
            currentViewDrinkData = drinksData
            var result: [ChartDataEntry] = []
            var i = 0
            for key in dayData.keys.sorted() {
                result.append(ChartDataEntry(x: Double(i), y: Double(dayData[key]!)))
                amount += dayData[key]!
                i += 1
            }
            target = 3500
            percent = Float(amount) / target
            if result.count == 1 {
                result.insert(ChartDataEntry(x: -1, y: 0), at: 0)
            }
            return result
        case .Yesterday:
            let day = getDate(interval: .Yesterday)
            var dayData: [String: Int] = [:]
            drinksData.forEach { key, value in
                if key.hasPrefix(day) {
                    dayData[String(key.split(separator: " ")[1])] = value
                }
            }
            currentViewDrinkData = drinksData
            var result: [ChartDataEntry] = []
            var i = 0
            for key in dayData.keys.sorted() {
                amount += dayData[key]!
                result.append(ChartDataEntry(x: Double(i), y: Double(dayData[key]!)))
                i += 1
            }
            target = 3500
            percent = Float(amount) / target
            if result.count == 1 {
                result.insert(ChartDataEntry(x: -1, y: 0), at: 0)
            }
            return result
        case .Week:
            let day = getDate(interval: .Week)
            var dayData: [String: Int] = [:]
            drinksData.forEach { key, value in
                let keyDate = String(key.split(separator: " ")[0])
                if day < keyDate {
                    if (dayData[keyDate] != nil) {
                        dayData[keyDate]! += value
                    } else {
                        dayData[keyDate] = value
                    }
                }
            }
            currentViewDrinkData = dayData
            
            var result: [ChartDataEntry] = []
            var i = 0
            for key in dayData.keys.sorted() {
                amount += dayData[key]!
                result.append(ChartDataEntry(x: Double(i), y: Double(dayData[key]!)))
                i += 1
            }
            target = 3500 * 7
            percent = Float(amount) / target
            if result.count == 1 {
                result.insert(ChartDataEntry(x: -1, y: 0), at: 0)
            }
            return result
            
        case .Month:
            let day = getDate(interval: .Month)
            var dayData: [String: Int] = [:]
            drinksData.forEach { key, value in
                let keyDate = String(key.split(separator: " ")[0])
                if day < keyDate {
                    if (dayData[keyDate] != nil) {
                        dayData[keyDate]! += value
                    } else {
                        dayData[keyDate] = value
                    }
                }
            }
            currentViewDrinkData = dayData
            var result: [ChartDataEntry] = []
            var i = 0
            for key in dayData.keys.sorted() {
                amount += dayData[key]!
                result.append(ChartDataEntry(x: Double(i), y: Double(dayData[key]!)))
                i += 1
            }
            if result.count == 1 {
                result.insert(ChartDataEntry(x: -1, y: 0), at: 0)
            }
            target = 3500 * 30
            percent = Float(amount) / target
            return result
        }
    }
}

@objc extension StatisticView {
    private func back() {
        dismiss(animated: true)
    }
}
