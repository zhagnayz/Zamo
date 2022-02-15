//
//  LabelNameCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/14/22.
//

import UIKit

class LabelNameCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "LabelNameCell"
    
    let nameLabel = UILabel()
    
    let separator = UIView(frame: .zero)
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        separator.backgroundColor = .quaternaryLabel
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textColor = .label
        
        let stackView = UIStackView(arrangedSubviews: [separator,nameLabel])
        
        stackView.spacing = 5
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
