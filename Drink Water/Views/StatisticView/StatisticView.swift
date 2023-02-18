//
//  StatisticView.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 18.02.2023.
//

import UIKit
import SnapKit

class StatisticView: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        layout()
    }
    
    private func initialize() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        menuItems = [
            UIAction(title: "Today", handler: { action in
                self.dayButton.setTitle("Today", for: .normal)
                self.dayButtonLayout()
            }),
            UIAction(title: "Yesterday", handler: { action in
                self.dayButton.setTitle("Yesterday", for: .normal)
                self.dayButtonLayout()
            }),
            UIAction(title: "Week", handler: { action in
                self.dayButton.setTitle("Week", for: .normal)
                self.dayButtonLayout()
            }),
            UIAction(title: "Month", handler: { action in
                self.dayButton.setTitle("Month", for: .normal)
                self.dayButtonLayout()
            })
        ]
        menu = UIMenu(children: menuItems)
        dayButton.menu = menu
        dayButton.showsMenuAsPrimaryAction = true
        view.addSubview(dayButton)

    }
    
}

extension StatisticView {
    private func layout() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(view.bounds.width * 0.1)
            make.top.equalToSuperview().offset(view.bounds.width * 0.15)
            make.height.equalTo(30)
        }
        dayButtonLayout()
    }
}

extension StatisticView {
    private func dayButtonLayout() {
        dayButton.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(40)
        }
        dayButton.imageView?.snp.makeConstraints { make in
            make.left.equalToSuperview()
        }
        dayButton.titleLabel?.snp.makeConstraints({ make in
            make.left.equalTo(dayButton.imageView!.snp.right)
        })
    }
}
