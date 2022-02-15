//
//  OrderedtemDetailsCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/14/22.
//

import UIKit

class OrderedtemDetailsCell: UICollectionViewCell {

    static let reuseIdentifier: String = "OrderedtemDetailsCell"
    
    let orderDetailsLabelStr = UILabel()
    let orderNumLabelStr = UILabel()
    let subTotalLabelStr = UILabel()
    let taxLabelStr = UILabel()
    let deliveryChargedLabelStr = UILabel()
    let totalAmountLabelStr = UILabel()
    let paymentMethodLabelStr = UILabel()
    let placedOnLabelStr = UILabel()
    
    let orderNumLabel = UILabel()
    let subTotalLabel = UILabel()
    let taxLabel = UILabel()
    let deliveryChargedLabel = UILabel()
    let totalAmountLabel = UILabel()
    let paymentMethodLabel = UILabel()
    let placedOnLabel = UILabel()
    
    let separator = UIView(frame: .zero)
    let separatorTwo = UIView(frame: .zero)
    let separatorThree = UIView(frame: .zero)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        orderDetailsLabelStr.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        subTotalLabelStr.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        subTotalLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

        totalAmountLabelStr.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        totalAmountLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        orderNumLabel.numberOfLines = 0
        
        separator.backgroundColor = .quaternaryLabel
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        separatorTwo.backgroundColor = .quaternaryLabel
        separatorTwo.translatesAutoresizingMaskIntoConstraints = false
        
        separatorThree.backgroundColor = .quaternaryLabel
        separatorThree.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewOne = UIStackView(arrangedSubviews: [orderNumLabelStr,orderNumLabel])
        stackViewOne.distribution = .equalSpacing
        
        let stackViewTwo = UIStackView(arrangedSubviews: [subTotalLabelStr,subTotalLabel])
        stackViewTwo.distribution = .equalSpacing

        let stackViewThree = UIStackView(arrangedSubviews: [taxLabelStr,taxLabel])
        stackViewThree.distribution = .equalSpacing
        
        let stackViewFour = UIStackView(arrangedSubviews: [deliveryChargedLabelStr,deliveryChargedLabel])
        stackViewFour.distribution = .equalSpacing
        
        let stackViewFive = UIStackView(arrangedSubviews: [totalAmountLabelStr,totalAmountLabel])
        stackViewFive.distribution = .equalSpacing
        
        let stackViewSix = UIStackView(arrangedSubviews: [paymentMethodLabelStr,paymentMethodLabel])
        stackViewSix.distribution = .equalCentering
        
        let stackViewSeven = UIStackView(arrangedSubviews: [placedOnLabelStr,placedOnLabel])
        stackViewSeven.distribution = .equalSpacing
        
        let stackView = UIStackView(arrangedSubviews: [separator,orderDetailsLabelStr,stackViewOne,stackViewTwo,stackViewThree,stackViewFour,stackViewFive,separatorTwo,stackViewSix,stackViewSeven,separatorThree])
        
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            separator.heightAnchor.constraint(equalToConstant: 1),
            separatorTwo.heightAnchor.constraint(equalToConstant: 1),
            separatorThree.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        stackView.setCustomSpacing(10, after: separator)
    }
    
    
    func configureOrderDetails(_ item: Order){
        
        orderDetailsLabelStr.text = "Order Details"
        orderNumLabelStr.text = "Order Num"
        subTotalLabelStr.text = "SubTotal"
        taxLabelStr.text = "Tax"
        deliveryChargedLabelStr.text = "Delivery Charge"
        totalAmountLabelStr.text = "Total Amount"
        paymentMethodLabelStr.text = "Payment Method"
        placedOnLabelStr.text = "Placed"
        
        orderNumLabel.text = "\(item.reference)"
        subTotalLabel.text = "\(item.formattedSubTotal)"
        taxLabel.text = "\(item.formattedTax)"
        deliveryChargedLabel.text = "\(item.formattedDeliveryCharge)"
        totalAmountLabel.text = "\(item.formattedGrandTotal)"
        paymentMethodLabel.text = "Card Payment"
        placedOnLabel.text = "\(item.date)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
