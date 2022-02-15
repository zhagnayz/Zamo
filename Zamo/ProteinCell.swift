//
//  ProteinCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/11/22.
//

import UIKit

class ProteinCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ProteinCell"
    
    let radioButton: UIButton = {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        return button
    }()
    
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let checked = UIImage(named: "Select")
    private let unchecked = UIImage(named: "UnSelect")
    
    let separator = UIView(frame: .zero)
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        separator.backgroundColor = .quaternaryLabel
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewOne = UIStackView(arrangedSubviews: [radioButton,nameLabel])
    
        stackViewOne.distribution = .fill
        stackViewOne.spacing = 10
        
        let stackViewTwo = UIStackView(arrangedSubviews: [stackViewOne,priceLabel])
        stackViewTwo.distribution = .equalSpacing
        
        let stackView = UIStackView(arrangedSubviews: [separator,stackViewTwo])
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(protein: [Protein], indexPath:IndexPath){
        
        nameLabel.text = protein[indexPath.item].name
        priceLabel.text = protein[indexPath.item].formattedPrice
        
        configureIsSelected(protein[indexPath.item].isSelected)
    }
    
    func configureIsSelected(_ value: Bool){
        
        let image = value ? checked : unchecked
        
        radioButton.setImage(image, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
