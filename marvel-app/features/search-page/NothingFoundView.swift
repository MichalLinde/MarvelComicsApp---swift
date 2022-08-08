//
//  NothingFoundView.swift
//  marvel-app
//
//  Created by Michal on 08/08/2022.
//

import Foundation
import UIKit

class NothingFoundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        
        self.addSubviews(notFoundText, notFoundImage)
        self.isHidden = true
        
        notFoundImage.center(inView: self)
        
        notFoundText.anchor(top: notFoundImage.bottomAnchor,
                            left: self.leftAnchor,
                            right: self.rightAnchor,
                            paddingLeft: SearchPageConstants.infoTextPadding,
                            paddingRight: SearchPageConstants.infoTextPadding)
    }
    
    lazy var notFoundText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: SearchPageConstants.notFoundTextSize, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var notFoundImage: UIImageView = {
        let image = UIImage(systemName: "xmark.circle.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.setHeight(SearchPageConstants.notFoundImageHeight)
        imageView.setWidth(SearchPageConstants.notFoundImageWidth)
        return imageView
    }()
}
