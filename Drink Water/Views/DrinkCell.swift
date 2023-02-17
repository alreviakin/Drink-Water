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
        return imageView
    }()
    private let sizeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(){
        
    }
    
}
