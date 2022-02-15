//
//  AlertController.swift
//  Zamo
//
//  Created by Macbook Pro on 2/14/22.
//

import Foundation
import UIKit

class AlertContoller {

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
                        
                        targetView.navigationController()?.pushViewController(receiptVC, animated: false)
                    }
                })
            }
        })
    }
}
