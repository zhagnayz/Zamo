//
//  FillAddressViewController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/15/22.
//

import UIKit

class FillAddressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let tableView = UITableView()
    
    let placeHolder = ["Street Address","Street Address 2 (optional)","City","State/Province","Zip Code"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Fill Address"
        
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        tableView.register(FillAddressCell.self, forCellReuseIdentifier: FillAddressCell.reuseIdentifier)
        
        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 10, bottom: 0, right: -10)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeHolder.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FillAddressCell.reuseIdentifier, for: indexPath) as? FillAddressCell else {fatalError()}
        
        cell.subtitle.text = placeHolder[indexPath.row]
        cell.placeHoldder =  placeHolder[indexPath.row]
        cell.dataTextField.delegate = self
        cell.dataTextField.tag = indexPath.row
        
        return cell
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.addTarget(self, action: #selector(didTapTextFieldSection), for: .editingChanged)
    }
    
    @objc func didTapTextFieldSection(_ textField: UITextField){
        
        print(textField.tag)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width-20, height: 70))
        
        
        let continueButton: UIButton = {
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: footerView.frame.size.width, height: 70))
            button.setTitle("Continue", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.backgroundColor = .tertiarySystemGroupedBackground
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
            button.addTarget(self, action: #selector(didTapContinueButtons), for: .touchUpInside)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 6
            button.layer.borderColor = UIColor.red.cgColor
            return button
        }()
        
        footerView.addSubview(continueButton)
        
        return footerView
    }
    
    @objc func didTapContinueButtons(){
        
        
    }
}
