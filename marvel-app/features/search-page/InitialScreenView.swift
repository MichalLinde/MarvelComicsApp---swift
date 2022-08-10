//
//  InitialScreenView.swift
//  marvel-app
//
//  Created by Michal on 08/08/2022.
//

import Foundation
import UIKit

class InitialScreenView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        self.isHidden = false
        
        self.addSubviews(initialImage, initialText)
        
        initialImage.center(inView: self)
        
        initialText.anchor(top: initialImage.bottomAnchor,
                           left: self.leftAnchor,
                           right: self.rightAnchor,
                           paddingLeft: SearchPageConstants.infoTextPadding,
                           paddingRight: SearchPageConstants.infoTextPadding)
    }
    
    private lazy var initialText: UILabel = {
        let label = UILabel()
        label.text = SearchPageConstants.initialText.localize()
        label.font = .systemFont(ofSize: SearchPageConstants.initialTextSize, weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private lazy var initialImage: UIImageView = {
        let image = UIImage(systemName: "book.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.setHeight(SearchPageConstants.initialImageHeight)
        imageView.setWidth(SearchPageConstants.initialImageWidth)
        return imageView
    }()
}
