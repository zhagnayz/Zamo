//
//  LocationCell.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class LocationCell: UICollectionViewCell, UITableViewDataSource {
    
    static let reuseIdentifier: String = "LocationCell"
    
    let tableView = UITableView()
    let placeHolder = ["* Use Current Address","+ Add Address"," Saved Address"]
    
    let checkmarkImg = UIImageView()

    let mutableAddressLabel = UILabel()
    let placeHolderLabel = UILabel()
    
    let separator = UIView(frame: .zero)
    let separatorTwo = UIView(frame: .zero)
    let separatorThree = UIView(frame: .zero)

    override init(frame: CGRect){
        super.init(frame: frame)
        
        tableView.separatorStyle = .none
        tableView.rowHeight = 70
        tableView.dataSource = self
        
        tableView.register(LongButtonTableCell.self, forCellReuseIdentifier: LongButtonTableCell.reuseIdentifier)
        
        let config = UIImage.SymbolConfiguration(pointSize: 40)
        checkmarkImg.image = UIImage(systemName: "checkmark.circle",withConfiguration: config)
        
        mutableAddressLabel.font = UIFont.systemFont(ofSize: 18,weight: .medium)
        mutableAddressLabel.textColor = .label
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        separatorTwo.translatesAutoresizingMaskIntoConstraints = false
        separatorTwo.backgroundColor = .quaternaryLabel
        
        separatorThree.translatesAutoresizingMaskIntoConstraints = false
        separatorThree.backgroundColor = .quaternaryLabel
        
        let stackViewOne = UIStackView(arrangedSubviews: [checkmarkImg,placeHolderLabel])
        
        let stackView = UIStackView(arrangedSubviews: [separator,tableView,separatorTwo,stackViewOne,mutableAddressLabel,separatorThree])
        
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
        stackView.setCustomSpacing(10, after: separatorTwo)
        stackView.setCustomSpacing(200, after: stackViewOne)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeHolder.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LongButtonTableCell.reuseIdentifier, for: indexPath) as? LongButtonTableCell else {fatalError()}
        
        cell.longButton.setTitle(placeHolder[indexPath.row], for: .normal)
        cell.longButton.tag = indexPath.row
        cell.longButton.addTarget(self, action: #selector(didTapLongButton), for: .touchUpInside)
        cell.longButton.backgroundColor = .tertiarySystemGroupedBackground
        return cell
    }
    
    
    @objc func didTapLongButton(_ sender: UIButton){
        
        if sender.tag == 0 {
            print(sender.tag)
            
        }else if sender.tag == 1 {
            
            let fillAddressVC = FillAddressViewController()
            
            navigationController()?.pushViewController(fillAddressVC, animated: false)
        }else {
            print(sender.tag)
        }
    }
}
