//
//  HomeViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/2/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate,UISearchResultsUpdating, UISearchBarDelegate{

    var restaurants: [Restaurant] = []{
        
        didSet{
            
            filteredRestaurants = restaurants
        }
    }
    
    var filteredRestaurants: [Restaurant] = []{
        
        didSet{
            
            reloadData()
        }
    }
    
    enum Section: Int{
        
        case section
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section,AnyHashable>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurants =  AppDataManager.shared.restauarants.sorted{$0.distance < $1.distance}
        
        collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: createCompositionalLayout())
        
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        view.addSubview(collectionView)
        
        collectionView.register(RestaurantsCell.self, forCellWithReuseIdentifier: RestaurantsCell.reuseIdentifier)
        
        collectionView.delegate = self
        
        createDataSource()
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedRestaurant = restaurants[indexPath.item]
        
        let destination = RestaurantViewController()
        
        destination.restaurant = selectedRestaurant
        
        navigationController?.pushViewController(destination, animated: false)
    }
    
    func createDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section,AnyHashable>(collectionView:collectionView){
            
            collectionView,indexPath, item in
            
            switch indexPath.section {
            
            case Section.section.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantsCell.reuseIdentifier, for: indexPath) as? RestaurantsCell else {fatalError("Unable to Deque \(RestaurantsCell.reuseIdentifier)")}
                
                cell.configure(self.restaurants, indexPath: indexPath)
                
                return cell
            
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    func reloadData(){
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,AnyHashable>()
        
        snapShot.appendSections([Section.section])
        
        snapShot.appendItems(restaurants,toSection: Section.section)
        
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
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(260))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    func filterRestaurants(nameOrCuisine searchText: String?,scope:Int = 0){
        
        if let searchText = searchText {
            
            let filterOnlyTheNearest = (scope > 0)
            
            filteredRestaurants = restaurants.filter({ (element) -> Bool in
                
                var didPass = false
                
                // If Name matches, consider the element
                if element.name.lowercased().contains(searchText.lowercased()) {
                    didPass = true
                } else { // Or Else if the Cuisine type exists and matches
                    if searchText.lowercased().contains(element.cuisine.lowercased()) {
                        didPass = true
                    }
                }
                
                // If the element is considered, check the scope and validate the distance preference too...
                if didPass && filterOnlyTheNearest {
                    didPass = (element.distance <= 5)
                }
                
                return didPass
            })
        } else {
            
            filteredRestaurants = restaurants
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {

         filterRestaurants(nameOrCuisine: searchController.searchBar.text, scope: searchController.searchBar.selectedScopeButtonIndex)
     }

     // MARK: UISearchBarDelegate
     func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

         filterRestaurants(nameOrCuisine: searchBar.text, scope: searchBar.selectedScopeButtonIndex)
     }
}


