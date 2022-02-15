//
//  RestaurantViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/13/22.
//

import UIKit

class RestaurantViewController: UIViewController, UICollectionViewDelegate {
    
    var restaurant: Restaurant?
    enum Section: Int{
        
        case section
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section,AnyHashable>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentRestaurant = restaurant {
            
            AppDataManager.shared.user.saveViewedRestaurant(currentRestaurant)
        }
        
        collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: createCompositionalLayout())
        
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        view.addSubview(collectionView)
        
        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.reuseIdentifier)
        
        collectionView.register(CategoryHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryHeaderReusableView.reuseIdentifier)
        
        
        collectionView.delegate = self
        
        createDataSource()
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedMenuItem = restaurant?.menuItem[indexPath.item]
        
        let destination = ItemDetailsViewController()
        
        destination.menuItem = selectedMenuItem
        
        navigationController?.pushViewController(destination, animated: false)
    }
    
    func createDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section,AnyHashable>(collectionView:collectionView){
            
            collectionView,indexPath, item in
            
            switch indexPath.section {
            
            case Section.section.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.reuseIdentifier, for: indexPath) as? MenuItemCell else {fatalError("Unable to Deque \(MenuItemCell.reuseIdentifier)")}
                
                cell.configureMenuItem(self.restaurant!.menuItem, indexPath: indexPath)
                
                let menuItem = MenuItem(from: self.restaurant!, itemIndex: indexPath.item)
                
                cell.quantityView.didPressButton = { item in

                    switch item {

                    case .plus:
                        AppDataManager.shared.user.cart.addItem(menuItem!)

                    case .minus:
                        AppDataManager.shared.user.cart.removeItem(menuItem!)
                    }
                }
                
                return cell
                
            default:
                return UICollectionViewCell()
            }
        }
        
        dataSource?.supplementaryViewProvider = {collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeaderReusableView.reuseIdentifier, for: indexPath) as? CategoryHeaderReusableView else {return nil}
            


            sectionHeader.itemImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
            sectionHeader.itemImage.image = UIImage(named: self.restaurant!.image)
            sectionHeader.nameLabel.nameLabel.text = self.restaurant?.name
            
            return sectionHeader
        }
    }
    
    func reloadData(){
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,AnyHashable>()
        
        snapShot.appendSections([Section.section])
        
        snapShot.appendItems(restaurant!.menuItem,toSection: Section.section)
        
        dataSource?.apply(snapShot)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout{
            
            sectionIndex, layoutEnvironment in
            
            guard let sectionType = Section(rawValue: sectionIndex) else {fatalError()}
            
            switch sectionType {
            
            case Section.section:
                
                return self.createRestaurantsSection()
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
        
        let layoutHeaderSection = createCategoryHeaderSection()
        
        layoutSection.boundarySupplementaryItems = [layoutHeaderSection]
        
        return layoutSection
    }
    
    func createCategoryHeaderSection() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let layoutHeaderSectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        
        let layoutHeaderSection = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutHeaderSectionSize,elementKind: UICollectionView.elementKindSectionHeader,alignment: .top)
        
        return layoutHeaderSection
    }
}
