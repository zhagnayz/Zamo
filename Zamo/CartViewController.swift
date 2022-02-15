//
//  CartViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/2/22.
//

import UIKit

class CartViewController: UIViewController {
    
    var cart: Cart {
        
        return AppDataManager.shared.user.cart
    }
    
    var newOrder: Order!
    
    enum Section: Int {
        
        case sectionOne
        case sectionTwo
        case sectionThree
        case sectionFour
    }
 
    var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section,AnyHashable>?
    
    let placeOrderButton: UIButton = {
        
        let button = UIButton()
        //let config = UIImage.SymbolConfiguration(pointSize: 40,weight: .semibold)
        button.setTitle("Place  Order", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20,weight: .semibold)
        button.layer.cornerRadius = 8
        button.backgroundColor = .red
        button.addTarget(self, action: #selector( didTaPlaceOrderButton), for: .touchDown)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "My Cart"
    
        collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        
        
        let stackView = UIStackView(arrangedSubviews: [collectionView,placeOrderButton])
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
        
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
        ])
        
//        collectionView.register(AddressCell.self, forCellWithReuseIdentifier: AddressCell.reuseIdentifier)
        
        collectionView.register(DeliveryAddressCell.self, forCellWithReuseIdentifier: DeliveryAddressCell.reuseIdentifier)
        
        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.reuseIdentifier)
        
        collectionView.register(TipButtonsSectionCell.self, forCellWithReuseIdentifier: TipButtonsSectionCell.reuseIdentifier)
        
        collectionView.register(PriceDetailsCell.self, forCellWithReuseIdentifier: PriceDetailsCell.reuseIdentifier)
        
        createDataSource()
        reloadData()
    }
    
    func createDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section,AnyHashable>(collectionView: collectionView){collectionView,indexPath, item in
            
            switch indexPath.section {
            
            case Section.sectionOne.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeliveryAddressCell.reuseIdentifier, for: indexPath) as? DeliveryAddressCell else {fatalError("Unable to dequeue \(DeliveryAddressCell.reuseIdentifier)")}
                
                cell.deliveryAtLabelStr.text = "Delivery At:"
                cell.addressChangedButton.addTarget(self, action: #selector(self.didTapChangeAddressButton), for: .touchUpInside)
                
                return cell
            
            case Section.sectionTwo.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.reuseIdentifier, for: indexPath) as? MenuItemCell else {fatalError("Unable to dequeue \(MenuItemCell.reuseIdentifier)")}
            
                cell.configureMenuItem(self.cart.items, indexPath: indexPath)
                
                return cell
                
            case Section.sectionThree.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipButtonsSectionCell.reuseIdentifier, for: indexPath) as? TipButtonsSectionCell else {fatalError("Unable to dequeue \(TipButtonsSectionCell.reuseIdentifier)")}
                
                cell.tipLabel.text = "ADD A TIP TO YOUR RIDER"
                
                return cell
            
            case Section.sectionFour.rawValue:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceDetailsCell.reuseIdentifier, for: indexPath) as? PriceDetailsCell else {fatalError("Unable to dequeue \(PriceDetailsCell.reuseIdentifier)")}
                
                self.newOrder = Order(cart: self.cart, deliveryCharge: 3.99)
                
                cell.configurePricceDetail(self.newOrder)
    
                return cell
                
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    func reloadData(){
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,AnyHashable>()
    
        snapShot.appendSections([Section.sectionOne,Section.sectionTwo,Section.sectionThree,Section.sectionFour])
                                   
        snapShot.appendItems(["jj"],toSection: Section.sectionOne)
        snapShot.appendItems(cart.items,toSection: Section.sectionTwo)
        snapShot.appendItems([""],toSection: Section.sectionThree)
        snapShot.appendItems([newOrder],toSection: Section.sectionFour)
        
        dataSource?.apply(snapShot)
    }
    
    @objc func didTapChangeAddressButton(){
        
        let destination = LocationViewController()
        
        navigationController?.pushViewController(destination, animated: false)
    }
    
    
    // AlertController
    
    @objc func didTaPlaceOrderButton(){
        
        let alertController = UIAlertController()
        
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        
        let cardImage = UIImage(systemName: "creditcard",withConfiguration: config)
        let cashImage = UIImage(systemName: "banknote",withConfiguration: config)
        
        let actionOne = UIAlertAction(title: "Card Payment", style: .default, handler:{ _ in
            
           // let cardPaymentVC = CardPaymentViewController()
            
            //self.navigationController?.pushViewController(cardPaymentVC, animated: false)
        })
        
        let actionTwo = UIAlertAction(title: "Cash on Delivery", style: .default, handler: {_ in
            
            self.showAlertFirst(with: "Order Placed Successfully", message: "Your Order Has Been\nPlaced Sucessfully", on: self)
            
        })
        
        actionOne.setValue(cardImage, forKey: "image")
        actionTwo.setValue(cashImage, forKey: "image")
        
        alertController.addAction(actionOne)
        alertController.addAction(actionTwo)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: false, completion: nil)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            
            sectionIndex, layoutEnvironment in
            
            guard let section = Section(rawValue: sectionIndex) else {fatalError()}
            
            switch section {
    
            case Section.sectionOne:
                return self.createAddressSection()
            
            case Section.sectionTwo:
                return self.createSelectedItemSection()
                
            case Section.sectionThree:
                
                return self.createAddressSection()
                
            case Section.sectionFour:
                return self.createPriceDetailsSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    func createAddressSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    func createSelectedItemSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(120))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    func createPriceDetailsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(340))
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        return layoutSection
    }
    
    // Alert Controller
    
    struct Constant {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView: UIView = {
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        
        return backgroundView
    }()
    
    private let alertView: UIView = {
        
        let alertView = UIView()
        alertView.backgroundColor = .systemBackground
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 5
        
        return alertView
    }()
    
    var myTargetView: UIView?
    
    func showAlertFirst(with title: String, message: String, on viewController: UIViewController){
        
        guard let targetView = viewController.view else {return}
        myTargetView = targetView
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width-90, height: 350)
    

        let titleLabel: UILabel = {

            let titleLabel = UILabel(frame: CGRect(x: 0, y: 10, width: alertView.frame.size.width, height: 90))
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 18,weight: .semibold)

            return titleLabel
        }()

        let messageLabel: UILabel = {

            let messageLabel = UILabel(frame: CGRect(x: 0, y: 80, width: alertView.frame.size.width, height: 140))
            messageLabel.text = message
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 18)
            messageLabel.numberOfLines = 0

            return messageLabel
        }()

        let backToCartButton: UIButton = {

            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Back To Cart", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.red.cgColor
            button.layer.cornerRadius = 6

            return button
        }()
        
        let orderConfirmButton: UIButton = {

            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Confirm And Send", for: .normal)
            button.addTarget(self, action: #selector(didTapOrderConfirmButton), for: .touchDown)
            button.layer.cornerRadius = 6
            button.setTitleColor(.label, for: .normal)
            button.backgroundColor = .red

            return button
        }()
        
        let stackView = UIStackView(arrangedSubviews: [backToCartButton,orderConfirmButton])
        
        stackView.spacing = 10
        stackView.frame = CGRect(x: 0, y: alertView.frame.size.height-62, width: alertView.frame.size.width-5, height: 50)

        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(stackView)
        
        UIView.animate(withDuration: 0.20, animations: {
            
            self.backgroundView.alpha = Constant.backgroundAlphaTo
        },completion: {_ in
            
            self.alertView.center = targetView.center
        })
    }
    
    @objc func didTapOrderConfirmButton(){
        guard let targetView = myTargetView else {return}
        
        UIView.animate(withDuration: 0.20, animations: {

            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width-90, height: 350)

        },completion: {done in

            if done {

                UIView.animate(withDuration: 0.20, animations: {

                    self.backgroundView.alpha = 0

                },completion: {done in

                    if done {

                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                        
                        self.showAlertSecond(with: "", message: "", on: self)
                    }
                })
            }
        })
    }
    
    
    /////////////////////////
    
    func showAlertSecond(with title: String, message: String, on viewController: UIViewController){
        
        guard let targetView = viewController.view else {return}
        myTargetView = targetView
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width-90, height: 350)
        

        let checkmarkImage: UIImageView = {

            let checkmarkImage = UIImageView(frame: CGRect(x: alertView.frame.size.width/2.5, y: 10, width: 80, height: 80))
            checkmarkImage.image = UIImage(systemName: "checkmark")

            return checkmarkImage
        }()


        let titleLabel: UILabel = {

            let titleLabel = UILabel(frame: CGRect(x: 0, y: 80, width: alertView.frame.size.width, height: 90))
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 18,weight: .semibold)

            return titleLabel
        }()


        let messageLabel: UILabel = {

            let messageLabel = UILabel(frame: CGRect(x: 0, y: 110, width: alertView.frame.size.width, height: 150))
            messageLabel.text = message
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 18)
            messageLabel.numberOfLines = 0

            return messageLabel
        }()

        let dismissAlertButton: UIButton = {

            let button = UIButton(frame: CGRect(x: 0, y: alertView.frame.size.height-50, width: alertView.frame.size.width, height: 50))
            button.setTitle("Ok", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.addTarget(self, action: #selector(didTapDismissAlertButton), for: .touchUpInside)
            button.backgroundColor = .tertiarySystemGroupedBackground

            return button
        }()

        alertView.addSubview(checkmarkImage)
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(dismissAlertButton)
        
        UIView.animate(withDuration: 0.20, animations: {
            
            self.backgroundView.alpha = Constant.backgroundAlphaTo
        },completion: {_ in
            
            self.alertView.center = targetView.center
        })
    }
    
    @objc func didTapDismissAlertButton(){
        guard let targetView = myTargetView else {return}
        
        UIView.animate(withDuration: 0.20, animations: {

            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width-90, height: 350)

        },completion: {done in

            if done {

                UIView.animate(withDuration: 0.20, animations: {

                    self.backgroundView.alpha = 0

                },completion: {done in

                    if done {

                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                        
                        let receiptVC = ReceiptViewController()
                        
                        receiptVC.order = self.newOrder
                        targetView.navigationController()?.pushViewController(receiptVC, animated: false)
                    }
                })
            }
        })
    }
}
