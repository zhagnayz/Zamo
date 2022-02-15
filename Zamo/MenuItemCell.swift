//
//  MenuItemCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/7/22.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "MenuItemCell"
    
    let itemImage = UIImageView()
    let itemTitle = UILabel()
    let itemDetails = UILabel()
    let itemPrice = UILabel()
    let itemTotal = UILabel()
    
    let quantityView = QuantityView()
    
    let separator = UIView(frame: .zero)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        separator.backgroundColor = .quaternaryLabel
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        itemImage.clipsToBounds = true
        itemImage.contentMode = .scaleAspectFill
        itemImage.layer.cornerRadius = 3
        
        itemImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        itemImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        itemTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        itemTitle.textColor = .label
        
        itemDetails.font = UIFont.preferredFont(forTextStyle: .subheadline)
        itemDetails.numberOfLines = 0
        itemDetails.textColor = .secondaryLabel
        
        itemPrice.font = UIFont.systemFont(ofSize: 15,weight: .semibold)
        itemPrice.textColor = .secondaryLabel
        
        itemTotal.font = UIFont.systemFont(ofSize: 17,weight: .semibold)
        itemTotal.textColor = .label
        
        quantityView.frame = CGRect(x: 0, y: 0, width: 115, height: 40)
        
        let stackViewOne = UIStackView(arrangedSubviews: [itemTitle,itemPrice,itemDetails])
        stackViewOne.axis = .vertical
        
        let stackViewTwo = UIStackView(arrangedSubviews: [quantityView])
        
        let stackViewThree = UIStackView(arrangedSubviews: [itemImage,stackViewOne,stackViewTwo])
        stackViewThree.spacing = 5
        
        let stackView = UIStackView(arrangedSubviews: [separator,stackViewThree])
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
        
        stackView.setCustomSpacing(10, after: separator)
    }
    
    func configureMenuItem(_ menu: [MenuItem],indexPath:IndexPath) {
        
        let menu = menu[indexPath.item]
        
        itemImage.image = UIImage(named: menu.image)
        itemTitle.text = menu.name
        itemDetails.text = menu.details
        itemPrice.text = menu.formattedPrice
        quantityView.count = menu.quantity
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
