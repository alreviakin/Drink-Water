//
//  ViewController.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 15.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var amountOfWater = 0
    private let data: [DrinkModel] = [
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
        initialize()
        layout()
    }
    
    private func initialize() {
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(drunkWaterLabel)
        view.addSubview(needToDrinkWaterLabel)
        view.addSubview(waterProgress)
        
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
        addButton.addSubview(addButtonImageView)
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DrinkCell
        cell.createCell(model: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        amountOfWater += data[indexPath.row].size
        UIView.animate(withDuration: 0.5) {
            self.waterProgress.setProgress(Float(self.amountOfWater) / 3500, animated: true)
        }
        drunkWaterLabel.moveInTransition(0.4)
        drunkWaterLabel.text = "\(amountOfWater)"
    }
    
}

@objc extension ViewController {
    private func presentStatView() {
        let statVC = StatisticView()
        statVC.modalPresentationStyle = .fullScreen
        present(statVC, animated: true)
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
