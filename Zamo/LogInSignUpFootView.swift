//
//  LogInSignUpFootView.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class LogInSignUpFootView: UIView {
    
    let SignUpButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    let agreeLabel: UILabel = {
        
        let agreeLabel = UILabel()
        
        agreeLabel.textColor = .gray
        agreeLabel.numberOfLines = 0
        agreeLabel.textAlignment = .center

        return agreeLabel
    }()
    
    let separator = UIView(frame: .zero)

    override init(frame: CGRect){
        super.init(frame: frame)

        separator.backgroundColor = .quaternaryLabel
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [separator,SignUpButton,agreeLabel])
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            separator.heightAnchor.constraint(equalToConstant: 1),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        stackView.setCustomSpacing(70, after: separator)
        stackView.setCustomSpacing(20, after: SignUpButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
