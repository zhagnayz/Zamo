//
//  HeaderReusableView.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    static let reuseIdentifier: String = "HeaderSection"
    
    let title = UILabel()
    let subtitle = UILabel()
    let requiredAndOptionalLabel = UILabel()
    
    
    let separator = UIView(frame: .zero)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 18, weight: .semibold))
        title.textColor = .label
        subtitle.textColor = .secondaryLabel
        requiredAndOptionalLabel.textColor = .label
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        let stackViwOne = UIStackView(arrangedSubviews: [subtitle,requiredAndOptionalLabel])
        stackViwOne.distribution = .equalSpacing
        
        let stackView = UIStackView(arrangedSubviews: [separator,title,stackViwOne])
        stackView.axis = .vertical
        stackView.spacing = 4

        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
        ])
        
        stackView.setCustomSpacing(10, after: separator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
