//
//  NameCircleView.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class NameCircleView: UIView {
    
    var nameLabel: UILabel = {
        
        let nameLabel = UILabel()
        
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        return nameLabel
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
        layer.cornerRadius = frame.size.width/2
        backgroundColor = .systemBackground
        
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor,constant: -70),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
