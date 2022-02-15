//
//  FillAddressCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class FillAddressCell: UITableViewCell {
    
    static let reuseIdentifier: String = "FillAddressCell"
    
    
    let separator = UIView(frame: .zero)
    let separatorTwo = UIView(frame: .zero)

    let subtitle = UILabel()
    
    let dataTextField: UITextField = {
        
        let dataTextField = UITextField()
        dataTextField.font = UIFont.systemFont(ofSize: 24,weight: .semibold)
        
        return dataTextField
    }()
    
    var placeHoldder: String? {
        
        didSet{
            
            guard let item = placeHoldder else {return}
            dataTextField.placeholder = item
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        separator.backgroundColor = .systemBackground
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        separatorTwo.backgroundColor = .systemBackground
        separatorTwo.translatesAutoresizingMaskIntoConstraints = false
        
        subtitle.font = UIFont.systemFont(ofSize: 15)
        subtitle.textColor = .label
        
        let stackView = UIStackView(arrangedSubviews: [subtitle,dataTextField,separator])
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            
            separator.heightAnchor.constraint(equalToConstant: 10),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        stackView.setCustomSpacing(10, after: separator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
