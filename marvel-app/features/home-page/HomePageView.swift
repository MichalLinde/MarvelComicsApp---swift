//
//  HomePageView.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import Foundation
import UIKit

class HomePageView: UIView {
    
    required init(){
        super.init(frame: CGRect.zero)
        self.backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
    }

}


