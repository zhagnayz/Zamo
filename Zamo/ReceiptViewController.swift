//
//  ReceiptViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/14/22.
//

import UIKit

class ReceiptViewController: UIViewController {

    var order: Order?
        
    enum Section: Int {

        case sectionOne
        case sectionTwo
        case sectionThree
    }
    
    var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section,AnyHashable>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AppDataManager.shared.user.saveOrder(order!)
        
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house",withConfiguration: config), style: .done, target: self, action: #selector(didTapHHouseButton))
        
        collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        view.addSubview(collectionView)
        
        collectionView.register(ReceiptTopCell.self, forCellWithReuseIdentifier: ReceiptTopCell.reuseIdentifier)

        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.reuseIdentifier)
        
        collectionView.register(OrderedtemDetailsCell.self, forCellWithReuseIdentifier: OrderedtemDetailsCell.reuseIdentifier)
        
        createDataSource()
        reloadData()
        
    }
    
    @objc func didTapHHouseButton(){
        
        navigationController?.popToRootViewController(animated: false)
    }
    
    func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section,AnyHashable>(collectionView: collectionView){collectionView,indexPath, item in
            
            switch indexPath.section{
            
            case Section.sectionOne.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReceiptTopCell.reuseIdentifier, for: indexPath) as? ReceiptTopCell else {fatalError("\(ReceiptTopCell.reuseIdentifier)")}
                
                cell.configureReceipt(self.order!)
                
                return cell
                
            case Section.sectionTwo.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.reuseIdentifier, for: indexPath) as? MenuItemCell else {fatalError("\(MenuItemCell.reuseIdentifier)")}
                
                cell.configureMenuItem(self.order!.items, indexPath: indexPath)
                cell.quantityView.isHidden = true
                return cell
                
            case Section.sectionThree.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderedtemDetailsCell.reuseIdentifier, for: indexPath) as? OrderedtemDetailsCell else {fatalError("\(OrderedtemDetailsCell.reuseIdentifier)")}
                
                cell.configureOrderDetails(self.order!)
                
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    func reloadData(){
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,AnyHashable>()
        
        snapShot.appendSections([Section.sectionOne,Section.sectionTwo,Section.sectionThree])
        
        snapShot.appendItems([""],toSection: Section.sectionOne)
        snapShot.appendItems(order!.items,toSection: Section.sectionTwo)
        snapShot.appendItems([order],toSection: Section.sectionThree)
        
        dataSource?.apply(snapShot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            sectionIndex, layoutEnvironment in
            
            guard let section = Section(rawValue: sectionIndex) else {fatalError()}
            
            switch section {
            
            case Section.sectionOne:
                return self.createReceiptSection()

            case Section.sectionTwo:
                return self.createSelectedItemsSection()
                
                
            case Section.sectionThree:
                return self.createOrderDetailsSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    
    func createReceiptSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    func createSelectedItemsSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    func createOrderDetailsSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(370))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
}
