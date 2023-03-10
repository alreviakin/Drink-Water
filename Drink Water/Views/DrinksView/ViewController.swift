//
//  ViewController.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 15.02.2023.
//

import UIKit
import SnapKit

enum KeyUserDefaults: String {
    case drinksData
}

class ViewController: UIViewController{
    private var amountOfWater = 0
    private var drinksData: [String: Int] = [:]
    private let defaultUser = UserDefaults.standard
    private let cellsData: [DrinkModel] = [
        DrinkModel(image: UIImage(named: "coffee")!, name: "Coffee", size: 50),
        DrinkModel(image: UIImage(named: "aqua")!, name: "Aqua", size: 100),
        DrinkModel(image: UIImage(named: "tea")!, name: "Tea", size: 150),
        DrinkModel(image: UIImage(named: "cola")!, name: "Cola", size: 200),
        DrinkModel(image: UIImage(named: "energy")!, name: "Energy", size: 200),
        DrinkModel(image: UIImage(named: "milkshake")!, name: "Milkshake", size: 200),
        DrinkModel(image: UIImage(named: "juice")!, name: "Juice", size: 200),
        DrinkModel(image: UIImage(named: "wine")!, name: "Wine", size: 50),
        DrinkModel(image: UIImage(named: "milk")!, name: "Milk", size: 50)
    ]
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Image.background
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily Drink Target"
        label.textColor = Resources.Color.whiteClear
        return label
    }()
    private let drunkWaterLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = Resources.Fonts.drunkWaterFont
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    private let needToDrinkWaterLabel: UILabel = {
        let label = UILabel()
        label.text = "/3500 ml"
        label.font = Resources.Fonts.needToDringWaterFont
        label.textColor = Resources.Color.whiteClear
        return label
    }()
    private let waterProgress: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = .white
        progress.backgroundColor = UIColor(white: 1, alpha: 0.1)
        progress.clipsToBounds = true
        return progress
    }()
    private var widthCell: CGFloat!
    private var heightCell: CGFloat!
    private var collection: UICollectionView!
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
        let nowDate = getCurrunDate(with: "yyyy:MM:dd")
        if let drinksData = defaultUser.object(forKey: KeyUserDefaults.drinksData.rawValue) as? [String : Int] {
            self.drinksData = drinksData
        }
        if !drinksData.isEmpty {
            for date in drinksData.keys {
                if date.hasPrefix(nowDate) {
                    amountOfWater += drinksData[date]!
                }
            }
        }
        initialize()
        layout()
    }
    
    private func initialize() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        drunkWaterLabel.text = "\(amountOfWater)"
        view.addSubview(drunkWaterLabel)
        view.addSubview(needToDrinkWaterLabel)
        view.addSubview(waterProgress)
        waterProgress.progress = Float(amountOfWater) / 3500
        
        let layout = UICollectionViewFlowLayout()
        widthCell = (view.bounds.width * 0.8  - 3) / 3
        heightCell = view.bounds.height / 6
        layout.itemSize = CGSize(width: widthCell, height: heightCell)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor(white: 1, alpha: 0.5)
        collection.layer.cornerRadius = 10
        collection.clipsToBounds = true
        collection.register(DrinkCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collection)
        
        view.addSubview(statButton)
        statButton.addSubview(statButtonImageView)
        statButton.addTarget(self, action: #selector(presentStatView), for: .touchUpInside)
        view.addSubview(notificationButton)
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addAmount), for: .touchUpInside)
        addButton.addSubview(addButtonImageView)
    }
    
    
}

extension ViewController {
    private func getCurrunDate(with format: String) -> String {
        let date = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return dateFormater.string(from: date)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DrinkCell
        cell.createCell(model: cellsData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            self.waterProgress.setProgress(Float(self.amountOfWater) / 3500, animated: true)
        }
                changeDrinkWaterLabel(amount: cellsData[indexPath.row].size)
    }
    
    private func changeDrinkWaterLabel(amount: Int) {
        amountOfWater += amount
        drunkWaterLabel.moveInTransition(0.4)
        drunkWaterLabel.text = "\(amountOfWater)"
        let currentDate = getCurrunDate(with: "yyyy:MM:dd HH")
        if (drinksData[currentDate] != nil) {
            drinksData[currentDate]! += amount
        } else {
            drinksData[currentDate] = amount
        }
        defaultUser.set(drinksData, forKey: KeyUserDefaults.drinksData.rawValue)
    }
}



@objc extension ViewController {
    private func presentStatView() {
        let statVC = StatisticView()
        statVC.modalPresentationStyle = .fullScreen
        statVC.configView(drinksData: drinksData)
        present(statVC, animated: true)
    }
    
    private func addAmount() {
        let alert = UIAlertController(title: "Add amount", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter the amount of water"
            textField.keyboardType = .numberPad
            textField.delegate = self
        }
        let actionAdd = UIAlertAction(title: "Add", style: .default) {_ in
            let amount = Int(String(alert.textFields![0].text!))!
            self.changeDrinkWaterLabel(amount: amount)
            
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
}

extension ViewController {
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
        
        drunkWaterLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(view.bounds.width * 0.25)
        }
        
        needToDrinkWaterLabel.snp.makeConstraints { make in
            make.bottom.equalTo(drunkWaterLabel.snp.bottom)
            make.left.equalTo(drunkWaterLabel.snp.right).offset(5)
            make.width.equalTo(view.bounds.width * 0.3)
            make.height.equalTo(30)
        }
        
        waterProgress.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(drunkWaterLabel.snp.bottom).offset(25)
            make.right.equalToSuperview().offset(view.bounds.width * -0.1)
            make.height.equalTo(16)
        }
        waterProgress.layer.cornerRadius = 8
        
        collection.snp.makeConstraints { make in
            make.right.equalTo(waterProgress.snp.right)
            make.left.equalTo(waterProgress.snp.left)
            make.top.equalTo(waterProgress.snp.bottom).offset(70)
            make.height.equalTo(heightCell * 3 + 2)
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

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 0 && string == "0" {
            return false
        }
        return true
    }
}


