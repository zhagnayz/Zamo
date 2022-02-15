//
//  CategoryHeaderReusableView.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class CategoryHeaderReusableView: UICollectionReusableView {

 static let reuseIdentifier: String = "CategoryHeaderReusableView"
 
 let itemImage = UIImageView()
    
    var nameLabel = NameCircleView()
 
 override init(frame: CGRect){
     super.init(frame: frame)
     
     itemImage.clipsToBounds = true
     itemImage.contentMode = .scaleAspectFill
     itemImage.layer.cornerRadius = 2
     
     
     let stackView = UIStackView(arrangedSubviews: [itemImage,nameLabel])
     stackView.axis = .vertical
     
     stackView.translatesAutoresizingMaskIntoConstraints = false
     
     addSubview(stackView)
     
     NSLayoutConstraint.activate([
     
         stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
         stackView.topAnchor.constraint(equalTo: topAnchor),
         stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
         stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
     ])
     
     
 }
 
 required init?(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
 }
}
