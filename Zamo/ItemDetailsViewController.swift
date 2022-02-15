//
//  ItemDetailsViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/13/22.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    var menuItem: MenuItem?
    enum Section: Int{
        
        case sectionOne
        case sectionTwo
        case sectionThree
        
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section,AnyHashable>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: createCompositionalLayout())
        
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        view.addSubview(collectionView)

        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.reuseIdentifier)
        
        collectionView.register(ProteinCell.self, forCellWithReuseIdentifier: ProteinCell.reuseIdentifier)
        
        collectionView.register(GarnishesCell.self, forCellWithReuseIdentifier: GarnishesCell.reuseIdentifier)
        
        createDataSource()
        reloadData()
        
    }
    
    func createDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section,AnyHashable>(collectionView:collectionView){
            
            collectionView,indexPath, item in
            
            switch indexPath.section {
            
            case Section.sectionOne.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.reuseIdentifier, for: indexPath) as? MenuItemCell else {fatalError("Unable to Deque \(MenuItemCell.reuseIdentifier)")}
                
                guard let menuItem = self.menuItem else {fatalError()}
                
                cell.itemTitle.text = menuItem.name
                cell.itemPrice.text = menuItem.formattedPrice
                cell.itemDetails.text = menuItem.details
                cell.itemImage.image = UIImage(named: menuItem.image)
                
                cell.quantityView.didPressButton = {item in
                    
                    switch item {
                    
                    case .plus:
                        AppDataManager.shared.user.cart.addItem(menuItem)
                        
                    case .minus:
                        AppDataManager.shared.user.cart.removeItem(menuItem)
                    }
                }
                
                return cell
                
            case Section.sectionTwo.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProteinCell.reuseIdentifier, for: indexPath) as? ProteinCell else {fatalError("Unable to Deque \(ProteinCell.reuseIdentifier)")}
                
                guard let menuItem = self.menuItem else {fatalError()}
                
                
                cell.configure(protein: menuItem.protein, indexPath: indexPath)
                
                return cell
                
            case Section.sectionThree.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GarnishesCell.reuseIdentifier, for: indexPath) as? GarnishesCell else {fatalError("Unable to Deque \(GarnishesCell.reuseIdentifier)")}
                
                guard let menuItem = self.menuItem else {fatalError()}
                
                
                cell.configure(garnish: menuItem.garnishes, indexPath: indexPath)
                
                return cell
                
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    func reloadData(){
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,AnyHashable>()
        
        snapShot.appendSections([Section.sectionOne,Section.sectionTwo,Section.sectionThree])
        
        snapShot.appendItems([menuItem],toSection: Section.sectionOne)
        snapShot.appendItems(menuItem!.protein,toSection: Section.sectionTwo)
        snapShot.appendItems(menuItem!.garnishes,toSection: Section.sectionThree)

        dataSource?.apply(snapShot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout{
            
            sectionIndex, layoutEnvironment in
            
            guard let sectionType = Section(rawValue: sectionIndex) else {fatalError()}
            
            switch sectionType {
            
            case Section.sectionOne:
                return self.createRestaurantsSection()
                
            case .sectionTwo:
                return self.createProteinSection()
                
            case .sectionThree:
                return self.createProteinSection()
            }
        }
        
        return layout
    }
    
    func createRestaurantsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(125))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    func createProteinSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
}
