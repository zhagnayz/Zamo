//
//  LocationViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class LocationViewController: UIViewController {

    let searchController: UISearchController = {
       let sc = UISearchController()
       sc.searchBar.placeholder = "Search location..."
       
       return sc
   }()
   
   var collectionView: UICollectionView!
   
   enum Section: Int {
       
       case sectionOne
   }
   var dataSource: UICollectionViewDiffableDataSource<Section,AnyHashable>?
   
   override func viewDidLoad() {
       super.viewDidLoad()
       
       title = "Search For Location"

       view.backgroundColor = .systemBackground
       navigationItem.searchController = searchController
   

       collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: createCompositionalLayout())
       collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
       collectionView.backgroundColor = .systemBackground

       view.addSubview(collectionView)
       
       collectionView.register(LocationCell.self, forCellWithReuseIdentifier: LocationCell.reuseIdentifier)
       
       createDataSource()
      reloadData()
   }
    
   func reloadData() {
       
       var snapShot = NSDiffableDataSourceSnapshot<Section,AnyHashable>()
       
    snapShot.appendSections([Section.sectionOne])
       snapShot.appendItems([""],toSection: Section.sectionOne)
    
    dataSource?.apply(snapShot)
   }

   func createDataSource(){
       
       dataSource = UICollectionViewDiffableDataSource<Section,AnyHashable>(collectionView: collectionView){collectionView,indexPath, item  in
           
        switch indexPath.section {
        
        case Section.sectionOne.rawValue:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.reuseIdentifier, for: indexPath) as? LocationCell else {fatalError()}
            
            cell.mutableAddressLabel.text = "Mutable Address"
            
            return cell
        default:
            return UICollectionViewCell()
        }
       }
   }
   
   func createCompositionalLayout() -> UICollectionViewLayout {
       
       let layout = UICollectionViewCompositionalLayout {
           
           sectionIndex, layoutEnvironment in
           
           guard let section = Section(rawValue: sectionIndex) else {fatalError()}
           
           switch section{
           
           case Section.sectionOne:
               return self.createLocationSection()
           }
       }
       
       return layout
   }
   
   func createLocationSection() -> NSCollectionLayoutSection {
    
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
       
       let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
       layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
       
       let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(520))
       
       let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
       
       let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
       
       
       return layoutSection
   }
}
