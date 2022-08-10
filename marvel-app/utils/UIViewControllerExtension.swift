//
//  UIViewControllerExtension.swift
//  marvel-app
//
//  Created by Michal on 10/08/2022.
//

import Foundation
import UIKit

extension UIViewController{
    func startIndicator(indicator: UIActivityIndicatorView){
        indicator.style = .large
        indicator.center = self.view.center
        indicator.isHidden = false
        self.view.addSubview(indicator)
        indicator.anchor(top: view.safeTopAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        indicator.startAnimating()
        indicator.backgroundColor = .white
    }
    
    func stopIndicator(indicator: UIActivityIndicatorView){
        indicator.stopAnimating()
        indicator.isHidden = true
    }
}
