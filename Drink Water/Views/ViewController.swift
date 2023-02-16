//
//  ViewController.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 15.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = Resources.Image.background
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    private let statButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        return button
    }()
    private var statButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Image.statistic
        return imageView
    }()
    private let notificationButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.imageView?.tintColor = .gray
        button.backgroundColor = .white
        return button
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.backgroundColor = Resources.Color.appGreen
        return button
    }()
    private let addButtonImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .white
        return imageView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        layout()
    }
    
    private func initialize() {
        view.addSubview(backgroundImageView)
        view.addSubview(statButton)
        statButton.addSubview(statButtonImageView)
        view.addSubview(notificationButton)
        view.addSubview(addButton)
        addButton.addSubview(addButtonImageView)
    }
    
    private func layout() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let buttonFrame = CGRect(x: 0, y: 0, width: (view.bounds.width * 0.15).rounded(), height: (view.bounds.width * 0.15).rounded())
        statButton.frame = buttonFrame
        statButton.layer.cornerRadius = statButton.bounds.height / 2
        statButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-statButton.bounds.width)
            make.bottom.equalToSuperview().offset(-statButton.bounds.width)
            make.width.height.equalTo((view.bounds.width * 0.15).rounded())
        }
        
        statButtonImageView.snp.makeConstraints({ make in
            make.left.top.equalToSuperview().offset(20)
            make.right.bottom.equalToSuperview().offset(-20)
        })
        notificationButton.frame = buttonFrame
        notificationButton.layer.cornerRadius = notificationButton.bounds.height / 2
        notificationButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(statButton.bounds.width)
            make.bottom.equalToSuperview().offset(-statButton.bounds.width)
            make.width.height.equalTo((view.bounds.width * 0.15).rounded())
        }
        addButton.frame = CGRect(x: 0, y: 0, width: (view.bounds.width * 0.2).rounded(), height: (view.bounds.width * 0.2).rounded())
        addButton.layer.cornerRadius = addButton.bounds.height / 2
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(notificationButton.snp.centerY)
            make.width.height.equalTo((view.bounds.width * 0.2).rounded())
        }
        addButtonImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }


}

