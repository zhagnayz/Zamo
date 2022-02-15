//
//  SignUpViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class SignUpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var placeHolder = ["First Name","Second Name","Email","Phone","Password","Repeat Password"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LogInSignUpCell.self, forCellReuseIdentifier: LogInSignUpCell.reuseIdentifier)
        
        setUpTableView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let quantityView = LogInSignUpButtonsCustom()
        quantityView.continueLabel.text = "or Sign Up With"
        return quantityView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let signup = LogInSignUpFootView()
        signup.agreeLabel.text = "By clicking Sign Up, Continue with Google, or continue with Apple, you agree to our Terms and Conditions and Privacy Statement"
        
        return signup
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return placeHolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LogInSignUpCell.reuseIdentifier,for: indexPath) as? LogInSignUpCell else {fatalError("Unable to Dequeue")}
        
        cell.placeHolderr = placeHolder[indexPath.row]
        cell.dataTextField.tag = indexPath.row
        cell.dataTextField.delegate = self
        
        return cell
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }
    
    enum DataTextField:Int {
        
        case firstNameTextField
        case lastNameTextField
        case emailTextField
        case phoneTextField
        case passwordTextField
        case repeatPasswordTextField
    }
    
    
    @objc func valueChanged(_ textField: UITextField){
        
//        var user: User?
//        switch textField.tag {
//
//        case DataTextField.firstNameTextField.rawValue:
//            user?.firstName = textField.text!
//
//        case DataTextField.lastNameTextField.rawValue:
//            user?.lastName = textField.text!
//
//        case DataTextField.emailTextField.rawValue:
//            user?.email = textField.text!
//
//        case DataTextField.phoneTextField.rawValue:
//            user?.phoneNumber = textField.text!
//
//        case DataTextField.passwordTextField.rawValue:
//            user?.password = textField.text!
//
//        case DataTextField.repeatPasswordTextField.rawValue:
//            user?.repeatPassword = textField.text!
//            textField.isSecureTextEntry = true
//
//        default:
//            break
//        }
//
    }
    
    func setUpTableView(){
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
