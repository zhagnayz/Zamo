//
//  PriceDetailsCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/7/22.
//

import UIKit

class PriceDetailsCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "PriceDetailsCell"
    
    let priceDetailsLabelStr = UILabel()
    let subTotalLabelStr = UILabel()
    let deliveryChargedLabelStr = UILabel()
    let tipAmountLabelStr = UILabel()
    let taxLabelStr = UILabel()
    let totaLabellStr = UILabel()
    
    let subTotalLabel = UILabel()
    let deliveryChargedLabel = UILabel()
    let tipAmountLabel = UILabel()
    let taxLabel = UILabel()
    let totalLabel = UILabel()
    
    let separator = UIView(frame: .zero)
    let separatorTwo = UIView(frame: .zero)
    let separatorThree = UIView(frame: .zero)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        
        priceDetailsLabelStr.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        priceDetailsLabelStr.textColor = .label
        
        subTotalLabelStr.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        subTotalLabel.textColor = .label
        
        totaLabellStr.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        totalLabel.textColor = .label
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        separatorTwo.translatesAutoresizingMaskIntoConstraints = false
        separatorTwo.backgroundColor = .quaternaryLabel
        
        separatorThree.translatesAutoresizingMaskIntoConstraints = false
        separatorThree.backgroundColor = .quaternaryLabel
        
        
        let stackViewOne = UIStackView(arrangedSubviews: [subTotalLabelStr,subTotalLabel])
        stackViewOne.spacing = 2
        let stackViewTwo = UIStackView(arrangedSubviews: [deliveryChargedLabelStr,deliveryChargedLabel])
        stackViewTwo.distribution = .equalSpacing
        
        let stackViewThree = UIStackView(arrangedSubviews: [tipAmountLabelStr,tipAmountLabel])
        stackViewThree.distribution = .equalSpacing
        
        let stackViewFour = UIStackView(arrangedSubviews: [taxLabelStr,taxLabel])
        let stackViewFive = UIStackView(arrangedSubviews: [totaLabellStr,totalLabel])
        stackViewFive.distribution = .equalSpacing
        
        let stackViewSix  = UIStackView(arrangedSubviews: [separatorTwo,separatorThree])
        stackViewSix.distribution = .fillEqually
        stackViewSix.spacing = 20
   
        
        let stackView = UIStackView(arrangedSubviews: [separator,priceDetailsLabelStr,stackViewOne,stackViewTwo,stackViewThree,stackViewFour,stackViewFive,stackViewSix])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            separator.heightAnchor.constraint(equalToConstant: 1),
            separatorTwo.heightAnchor.constraint(equalToConstant: 1),
            separatorTwo.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        stackView.setCustomSpacing(10, after: separator)
    }
    
    
    func configurePricceDetail(_ order: Order){
        
        priceDetailsLabelStr.text = "Price Details"
        subTotalLabelStr.text = "SubTotal"
        deliveryChargedLabelStr.text = "Delivery Charged"
        tipAmountLabelStr.text = "Tip Amount"
        taxLabelStr.text = "Tax"
        totaLabellStr.text = "GrandTotal"
        
        subTotalLabel.text = "\(order.formattedSubTotal)"
        deliveryChargedLabel.text = "\(order.formattedDeliveryCharge)"
        taxLabel.text = "\(order.formattedTax)"
        totalLabel.text = "\(order.formattedGrandTotal)"

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
