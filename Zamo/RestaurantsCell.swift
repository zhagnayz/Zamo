//
//  RestaurantsCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/7/22.
//

import UIKit

class RestaurantsCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "RestaurantsCell"
    
   
    let nameLabel = UILabel()
    let cuisineLabel = UILabel()
    let descriptionLabel = UILabel()
    let restImage = UIImageView()
    let reviewRatingLabel = UILabel()
    let costRatingLabel = UILabel()

    let separator = UIView(frame: .zero)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        restImage.clipsToBounds = true
        restImage.contentMode = .scaleAspectFill
        restImage.layer.cornerRadius = 3
        
        nameLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .bold))
        nameLabel.textColor = .label
        
        cuisineLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 13, weight: .semibold))
        cuisineLabel.textColor = .gray
        
        descriptionLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 13, weight: .semibold))
        descriptionLabel.textColor = .systemGray2
        
        reviewRatingLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .bold))
        reviewRatingLabel.textColor = .label
        
        costRatingLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .bold))
        costRatingLabel.textColor = .label
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        let stackViewOne = UIStackView(arrangedSubviews: [nameLabel,costRatingLabel])
        stackViewOne.distribution = .equalSpacing
        
        
        let stackViewTwo = UIStackView(arrangedSubviews: [cuisineLabel,descriptionLabel])
        stackViewTwo.distribution = .fill
        stackViewTwo.spacing = 5
        
        let stackViewThree = UIStackView(arrangedSubviews: [stackViewTwo,reviewRatingLabel])
        stackViewThree.distribution = .equalSpacing
        
        let stackView = UIStackView(arrangedSubviews: [separator,restImage,stackViewOne,stackViewThree])
        stackView.axis = .vertical
        stackView.spacing = 7
        
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
    
    func configure(_ rest: [Restaurant],indexPath: IndexPath) {

        nameLabel.text = rest[indexPath.item].name
        cuisineLabel.text = rest[indexPath.item].cuisine
        descriptionLabel.text = rest[indexPath.item].description
        restImage.image = UIImage(named: rest[indexPath.item].image)
        reviewRatingLabel.text = "\(rest[indexPath.item].reviewRating)"
        costRatingLabel.text = "\(rest[indexPath.item].costRating)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
