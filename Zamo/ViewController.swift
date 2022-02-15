//
//  ViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/2/22.
//

import UIKit

class ViewController: UITabBarController {
    
    let homeVC = UINavigationController(rootViewController: HomeViewController())
    let pickUpVC = UINavigationController(rootViewController: PickUpViewController())
    let cartVC = UINavigationController(rootViewController: CartViewController())
    let searchVC = UINavigationController(rootViewController: SearchViewController())
    let accountVC = UINavigationController(rootViewController: AccountViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartBadge), name: AppDataManager.orderUpdateNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCartBadge()
    }
    
    @objc func updateCartBadge(){
        
        let cartCount = AppDataManager.shared.user.cart.totalItems
        
        cartVC.tabBarItem.badgeValue = cartCount > 0 ? String(cartCount) : "0"
    }
    
    func setUpTabBar(){
        
        homeVC.title = "Home"
        pickUpVC.title = "PickUp"
        cartVC.title = "Cart"
        searchVC.title = "Search"
        accountVC.title = "Account"
        
        let iconImages = ["house","figure.walk","cart","magnifyingglass","person.circle"]
        
        setViewControllers([homeVC,pickUpVC,cartVC,searchVC,accountVC], animated: false)
        
        guard let tabBarItems = tabBar.items else {return}
        
        for item in 0..<tabBarItems.count {
            
            tabBarItems[item].image = UIImage(systemName: iconImages[item])
        }
    }
    
}

