//
//  DeliveryAddressCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class DeliveryAddressCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "DeliveryAddressCell"
    
    let deliveryAtLabelStr = UILabel()
    let mutableAddressLabelStr = UILabel()
    
    let addressChangedButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Change", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    let separator = UIView(frame: .zero)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        deliveryAtLabelStr.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        deliveryAtLabelStr.textColor = .label
        
        mutableAddressLabelStr.font = UIFont.systemFont(ofSize: 18)
        mutableAddressLabelStr.textColor = .label
        
        
        let stackViewOne = UIStackView(arrangedSubviews: [mutableAddressLabelStr,addressChangedButton])
        stackViewOne.spacing = 5
        
        let stackView = UIStackView(arrangedSubviews: [separator,deliveryAtLabelStr,stackViewOne])
        stackView.axis = .vertical
        stackView.spacing = 8
        
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
    
//    func configureAddresCellWith(item: Address){
//        
//        deliveryAtLabelStr.text = item.deliveryAtStr
//        mutableAddressLabelStr.text = item.mutableAddressStr
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
