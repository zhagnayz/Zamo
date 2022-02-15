//
//  LogInViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class LogInViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let placeholder = ["Email","Password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LogInSignUpCell.self, forCellReuseIdentifier: LogInSignUpCell.reuseIdentifier)
        
        setUpTableView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholder.count}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let loginButton = LogInSignUpButtonsCustom()
        loginButton.continueLabel.text = "or Continue With Email"
        
        return loginButton
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let login =  LogInSignUpFootView()
        login.agreeLabel.text = "LogIn,You Won't Regret"
        
        return login
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LogInSignUpCell.reuseIdentifier,for: indexPath) as? LogInSignUpCell else {fatalError("Unable to dequeue")}
        
        cell.placeHolderr = placeholder[indexPath.row]
        cell.dataTextField.tag = indexPath.row
        
        return cell
    }
    
    
    func setUpTableView(){
        
        view.addSubview(tableView)
        //tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
