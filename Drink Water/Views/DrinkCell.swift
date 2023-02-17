//
//  DrinkCell.swift
//  Drink Water
//
//  Created by Алексей Ревякин on 17.02.2023.
//

import UIKit

class DrinkCell: UICollectionViewCell {
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    private var widthContentView: CGFloat!
    private var heightContentView: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        widthContentView = contentView.bounds.width
        heightContentView = contentView.bounds.height
        initialize()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(){
        contentView.backgroundColor = Resources.Color.whiteClear
        contentView.addSubview(imageView)
        contentView.addSubview(sizeLabel)
        contentView.addSubview(nameLabel)
    }
    
    private func layout() {
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(widthContentView * 0.3)
            make.right.equalToSuperview().offset(-widthContentView * 0.3)
            make.top.equalToSuperview().offset(heightContentView * 0.2)
            make.height.equalTo(heightContentView * 0.4)
        }
        sizeLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.left)
            make.right.equalTo(imageView.snp.right)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(10)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.left)
            make.right.equalTo(imageView.snp.right)
            make.top.equalTo(sizeLabel.snp.bottom).offset(7)
            make.height.equalTo(10)
        }
    }
    
    func createCell(model: DrinkModel) {
        imageView.image = model.image
        sizeLabel.text = model.size
        nameLabel.text = model.name
    }
    
}
