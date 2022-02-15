//
//  LongButtonTableCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class LongButtonTableCell: UITableViewCell {

    static let reuseIdentifier: String = "LongButtonTableCell"
    
    let longButton: UIButton = {
        
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return button
    }()
    
    let separator = UIView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .systemBackground
        
        let stackView = UIStackView(arrangedSubviews: [longButton,separator])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            separator.heightAnchor.constraint(equalToConstant: 12),
            
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
