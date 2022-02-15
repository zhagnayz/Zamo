//
//  AccountViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/2/22.
//

import UIKit

class AccountViewController: UIViewController {
    
    private lazy var LogInVC = LogInViewController()
    private lazy var SignUpVC = SignUpViewController()
    
    let segmentedController: UISegmentedControl = {
        
        let items = ["LogIn","SignUp"]
        let sc = UISegmentedControl(items: items)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        sc.selectedSegmentIndex = 0
        sc.setTitleTextAttributes(textAttributes, for: .selected)
        sc.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        sc.setWidth(120, forSegmentAt: 0)
        sc.setWidth(120, forSegmentAt: 1)

        return sc
    }()
    
    let scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedController.addTarget(self, action: #selector(didTapSegmentedButtons), for: .valueChanged)

        navigationItem.titleView = segmentedController
        
        setUpScrollView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: view.frame.size.width*2, height: 0)
        
        addChildVCs()
    }
    
    func addChildVCs(){
        
        scrollView.addSubview(LogInVC.view)
        scrollView.addSubview(SignUpVC.view)
        
        LogInVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        
        SignUpVC.view.frame = CGRect(x: scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        
        LogInVC.didMove(toParent: self)
        SignUpVC.didMove(toParent: self)
    }
    
    @objc func didTapSegmentedButtons(_ sender: UISegmentedControl){
        
        if segmentedController.selectedSegmentIndex == 0 {
            scrollView.setContentOffset(.zero, animated: false)
        }else {
            scrollView.setContentOffset(CGPoint(x: view.frame.size.width, y: 0), animated: false)
        }
    }
    
    func setUpScrollView(){
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor,constant: 90),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
