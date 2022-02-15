//
//  LogInSignUpCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class LogInSignUpCell: UITableViewCell {
    
    static let reuseIdentifier: String = "LogInSignUpCell"
    
    let dataTextField: UITextField = {
        
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 40)
        
        return field
    }()
    
    var placeHolderr: String? {
        
        didSet {
            
            guard let userInfo = placeHolderr else {return}
            
            dataTextField.placeholder = userInfo
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpDataTextField()
    }
    
    
    func setUpDataTextField(){
        
        contentView.addSubview(dataTextField)
        
        NSLayoutConstraint.activate([
            
            dataTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dataTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dataTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
