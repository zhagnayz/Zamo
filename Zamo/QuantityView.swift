//
//  QuantityView.swift
//  Zamo
//
//  Created by Macbook Pro on 2/7/22.
//

import UIKit

class QuantityView: UIView {
    
    let addButton: UIButton = {
        
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 33)
        
        button.setImage(UIImage(systemName: "plus.circle.fill",withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    let deleteButton: UIButton = {
        
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 33)
        
        button.setImage(UIImage(systemName: "minus.circle.fill",withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.tag = 1
        
        return button
    }()
    
    let valueLabel = UILabel()
    
    var count:Int = 0 {
        
        didSet {
            
            valueLabel.text = "\(count)"
        }
    }
    
    enum QuantityViewItems: Int {
        
        case plus
        case minus
    }
    
    var didPressButton: ((QuantityViewItems)->())?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        valueLabel.text = "\(count)"
        valueLabel.font = UIFont.systemFont(ofSize: 33)
        
        let stackView = UIStackView(arrangedSubviews: [deleteButton,valueLabel,addButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        stackView.spacing = 5
    }
    
    func validate() -> Bool {
        
        if(count < 0) {
            return false
        }else {
            return true
        }
    }
    
    @objc func didTapButton(_ sender: UIButton){
        // guard validate() == true else {return}
        if let selectedButton = QuantityViewItems(rawValue: sender.tag){
            
            switch selectedButton {
            
            case .plus:
                count += 1
                
            case .minus:
                count > 0 ? count -= 1 : nil
            }
            
            didPressButton?(selectedButton)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
