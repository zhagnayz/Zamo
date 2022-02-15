//
//  NavigationController_Extension.swift
//  Zamo
//
//  Created by Macbook Pro on 2/14/22.
//

import Foundation
import UIKit

extension UIView {

    func controller() -> UIViewController? {
        if let nextViewControllerResponder = next as? UIViewController {
            return nextViewControllerResponder
        }
        else if let nextViewResponder = next as? UIView {
            return nextViewResponder.controller()
        }
        else  {
            return nil
        }
    }

    func navigationController() -> UINavigationController? {
        if let controller = controller() {
            return controller.navigationController
        }
        else {
            return nil
        }
    }
}
