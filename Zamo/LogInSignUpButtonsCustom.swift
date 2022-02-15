//
//  LogInSignUpButtonsCustom.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit
import AuthenticationServices

class LogInSignUpButtonsCustom: UIView {
    
    let googleLoginButton: UIButton = {
        
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 33)
        
        button.setImage(UIImage(systemName: "network",withConfiguration: config), for: .normal)
        button.setTitle("Continue with Google", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    let appleLoginButton: ASAuthorizationAppleIDButton = {
        
        let button = ASAuthorizationAppleIDButton()
        
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    let continueLabel: UILabel = {
        
        let label = UILabel()
        
        label.textAlignment = .center
        label.textColor = .gray
        
        return label
    }()
    
    let separator = UIView(frame: .zero)

    override init(frame: CGRect){
        super.init(frame: frame)
        
        separator.backgroundColor = .quaternaryLabel
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [separator,googleLoginButton,appleLoginButton,continueLabel])
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -25),
        ])
        
        stackView.setCustomSpacing(20, after: separator)
        stackView.spacing = 10
        stackView.setCustomSpacing(15, after: appleLoginButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
