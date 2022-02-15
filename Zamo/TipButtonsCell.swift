//
//  TipButtonsCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/7/22.
//

import UIKit

class TipButtonsCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "TipButtonsCell"
    
    let button: UIButton = {
        
        let button = UIButton()
        
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        return button
    }()
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        
        initButton()
    }
    
    func initButton(){
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
