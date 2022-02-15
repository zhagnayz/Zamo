//
//  TipButtonsSectionCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/7/22.
//

import UIKit

class TipButtonsSectionCell: UICollectionViewCell, UICollectionViewDataSource {
    
    static let reuseIdentifier: String = "TipButtonsSectionCell"
    
    let separator = UIView(frame: .zero)

    let tipLabel = UILabel()

    var placeHolder = ["+$1","+$3","+$5","+$7","+$9","+$11"]
    
    var collectionView: UICollectionView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        separator.backgroundColor = .quaternaryLabel
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        tipLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        tipLabel.textColor = .label
        
        collectionView = UICollectionView(frame: contentView.bounds,collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        collectionView.register(TipButtonsCell.self, forCellWithReuseIdentifier: TipButtonsCell.reuseIdentifier)
        
        collectionView.dataSource = self
        
        
        let stackView = UIStackView(arrangedSubviews: [separator,tipLabel,collectionView])
        stackView.spacing = 15
        stackView.axis = .vertical
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return placeHolder.count}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipButtonsCell.reuseIdentifier, for: indexPath) as? TipButtonsCell else {fatalError()}
        
        cell.button.setTitle(placeHolder[indexPath.item], for: .normal)
        cell.backgroundColor = .systemBlue
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 6
        cell.button.tag = indexPath.item
        cell.button.addTarget(self, action: #selector(didTapTipButtons), for: .touchUpInside)
        
        return cell
    }
    
    @objc func didTapTipButtons(_ sender: UIButton){
        
        print(sender.tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
