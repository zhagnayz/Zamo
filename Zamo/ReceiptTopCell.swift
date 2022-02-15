//
//  ReceiptTopCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/14/22.
//

import UIKit

class ReceiptTopCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ReceiptTopCell"
    
    let statusLabelStr = UILabel()
    let paymentLabelStr = UILabel()
    let itemsLabelStr = UILabel()
    
    let statusLabel = UILabel()
    let paymentLabel = UILabel()
    let itemsLabel = UILabel()
    
    
    let separator = UIView(frame: .zero)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        statusLabelStr.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        paymentLabelStr.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        itemsLabelStr.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        separator.backgroundColor = .quaternaryLabel
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewOne = UIStackView(arrangedSubviews: [statusLabelStr,statusLabel])
        stackViewOne.axis = .vertical
        stackViewOne.distribution = .fill
        stackViewOne.spacing = 10
        
        let stackViewTwo = UIStackView(arrangedSubviews: [paymentLabelStr,paymentLabel])
        stackViewTwo.axis = .vertical
        stackViewTwo.distribution = .fill
        stackViewTwo.spacing = 10
        
        let stackViewThree = UIStackView(arrangedSubviews: [itemsLabelStr,itemsLabel])
        stackViewThree.axis = .vertical
        stackViewThree.distribution = .fill
        stackViewThree.spacing = 10
        
        let stackViewFour = UIStackView(arrangedSubviews: [stackViewOne,stackViewTwo,stackViewThree])
        stackViewFour.distribution = .equalSpacing
        
        let stackView = UIStackView(arrangedSubviews: [separator,stackViewFour])
        stackView.axis = .vertical
        //stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        stackView.setCustomSpacing(10, after: separator)
    }
    
    
    func configureReceipt(_ item: Order){
      
        statusLabelStr.text = "Status"
        paymentLabelStr.text = "Payment"
        itemsLabelStr.text = "Item(s)"
        
        statusLabel.text = "Placed"
        paymentLabel.text = "\(item.formattedGrandTotal)"
        //itemsLabel.text = "\(AppDataManager.shared.user.cart.items[0].formattedQuantity)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
