//
//  SearchViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/2/22.
//

import UIKit

class SearchViewController: UIViewController,UISearchControllerDelegate, UICollectionViewDelegate {

    private var searchController: UISearchController!
    
    private var cuisines = [String]()
    private var restaurantsLastViewed = [Restaurant]()
    private var orderHistory = [Order]()
    
    enum Section: Int {
        
        case sectionOne
        case sectionTwo
        case sectionThree
    }
    
    var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section,AnyHashable>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Search For Food"
        navigationItem.hidesSearchBarWhenScrolling = false
        
        collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        view.addSubview(collectionView)
        
        collectionView.register(LabelNameCell.self, forCellWithReuseIdentifier: LabelNameCell.reuseIdentifier)
        
        collectionView.delegate = self
        
        setupSearchController()
        setupData()
        
        createDataSource()
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        restaurantsLastViewed = AppDataManager.shared.user.restaurantsLastViewed
        orderHistory = AppDataManager.shared.user.orderHistory
        
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == Section.sectionOne.rawValue {
            
            let selectedRestaurantsLastViewed = restaurantsLastViewed[indexPath.item]
            
            let destination = RestaurantViewController()
            
            destination.restaurant = selectedRestaurantsLastViewed
            
            navigationController?.pushViewController(destination, animated: false)
            
        }else if indexPath.section == Section.sectionTwo.rawValue{
            
            searchController.searchBar.text = cuisines[indexPath.item]
            searchController.searchBar.becomeFirstResponder()
            
        }else if indexPath.section == Section.sectionThree.rawValue {
            
            //let selectedOrderHistory = orderHistory[indexPath.item]
        }
    }

    func createDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section,AnyHashable>(collectionView:collectionView){
            
            collectionView,indexPath, item in
            
            switch indexPath.section {
            
            case Section.sectionOne.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelNameCell.reuseIdentifier, for: indexPath) as? LabelNameCell else {fatalError("Unable dequeue \(LabelNameCell.reuseIdentifier)")}
                
                cell.nameLabel.text = self.restaurantsLastViewed[indexPath.item].name


                return cell
                
            case Section.sectionTwo.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelNameCell.reuseIdentifier, for: indexPath) as? LabelNameCell else {fatalError("Unable dequeue \(LabelNameCell.reuseIdentifier)")}
                
                cell.nameLabel.text = self.cuisines[indexPath.item]

                return cell
                
            case Section.sectionThree.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelNameCell.reuseIdentifier, for: indexPath) as? LabelNameCell else {fatalError("Unable dequeue \(LabelNameCell.reuseIdentifier)")}
                
                cell.nameLabel.text = "History Order Not Completen"
                
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    func reloadData(){
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,AnyHashable>()
        
        snapShot.appendSections([Section.sectionOne,Section.sectionTwo,Section.sectionThree])
        
        snapShot.appendItems(restaurantsLastViewed,toSection: Section.sectionOne)
        snapShot.appendItems(cuisines,toSection: Section.sectionTwo)
        snapShot.appendItems(orderHistory,toSection: Section.sectionThree)
        
        dataSource?.apply(snapShot)
    }
    
    func setupData(){
        
        restaurantsLastViewed = AppDataManager.shared.user.restaurantsLastViewed
        orderHistory = AppDataManager.shared.user.orderHistory
        
        for item in AppDataManager.shared.restauarants {
            
            cuisines.append(item.cuisine)
        }
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout{
            
            sectionIndex, layoutEnvironment in
            
            guard let sectionType = Section(rawValue: sectionIndex) else {fatalError()}
            
            switch sectionType {
            
            case Section.sectionOne:
                return self.createRestaurantsSection()
                
            case .sectionTwo:
                return self.createRestaurantsSection()
                
            case .sectionThree:
                return self.createRestaurantsSection()
            }
        }
        
        return layout
    }
    
    func createRestaurantsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    private func setupSearchController(){

        let searchResultsController = HomeViewController()
        
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController

        searchController.delegate = self
        searchController.searchBar.delegate = searchResultsController

        // Update Search Bar's properties
        searchController.searchBar.placeholder = "Restaurant or Cuisine"
        searchController.searchBar.scopeButtonTitles = ["All","< 5 Miles"]
        searchController.searchBar.sizeToFit()

        // Add Search Bar to the view
        navigationItem.searchController = searchController
    }
}

