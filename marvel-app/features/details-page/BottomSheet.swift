//
//  BottomSheet.swift
//  marvel-app
//
//  Created by Michal on 09/08/2022.
//

import Foundation
import UIKit

class BottomSheet: UIViewController {
    
    var comic: Comic?
    
    required init(comic: Comic?){
        super.init(nibName: nil, bundle: nil)
        self.comic = comic
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .white

        view.addSubviews( titleLabel, authorLabel, descriptionLabel, moreButton)
        
        titleLabel.anchor(top: view.topAnchor,
                          left: view.leftAnchor,
                          right: view.rightAnchor,
                          paddingTop: DetailsPageConstants.sheetTextTopPadding,
                          paddingLeft: DetailsPageConstants.sheetLabelsPadding,
                          paddingRight: DetailsPageConstants.sheetLabelsPadding)
        
        authorLabel.anchor(top: titleLabel.bottomAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingTop: DetailsPageConstants.sheetLabelsPadding,
                           paddingLeft: DetailsPageConstants.sheetLabelsPadding,
                           paddingRight: DetailsPageConstants.sheetLabelsPadding)
        
        descriptionLabel.anchor(top: authorLabel.bottomAnchor,
                                left: view.leftAnchor,
                                right: view.rightAnchor,
                                paddingTop: DetailsPageConstants.sheetLabelsPadding,
                                paddingLeft: DetailsPageConstants.sheetLabelsPadding,
                                paddingRight: DetailsPageConstants.sheetLabelsPadding)
        
        moreButton.anchor(left: view.leftAnchor,
                          bottom: view.bottomAnchor,
                          right: view.rightAnchor,
                          paddingLeft: DetailsPageConstants.moreButtonHorizontalPadding,
                          paddingBottom: DetailsPageConstants.moreButtonBottomPadding,
                          paddingRight: DetailsPageConstants.moreButtonHorizontalPadding,
                          height: DetailsPageConstants.moreButtonHeight
                          )
        moreButton.setTitle(DetailsPageConstants.moreButtonText, for: .normal)
        
    }
    
    private lazy var grabber: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "minus")
        imageView.tintColor = .gray
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = comic?.getComicTitle(comic: comic)
        label.font = .systemFont(ofSize: DetailsPageConstants.titleFontSize, weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = getAuthors(comic: comic)
        label.font = .systemFont(ofSize: DetailsPageConstants.authorsFontSize)
        label.textColor = .darkGray
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = comic?.getDescription(comic: comic)
        label.font = .systemFont(ofSize: DetailsPageConstants.descriptionFontSize)
        label.textColor = .black
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .white
        button.backgroundColor = .red
        button.titleLabel?.font = .systemFont(ofSize: DetailsPageConstants.moreButtonFontSize, weight: .medium)
        button.layer.cornerRadius = DetailsPageConstants.moreButtonCornerRadius
        button.addTarget(self, action: #selector(redirectToUrl), for: .touchUpInside)
        return button
    }()
    
    @objc func redirectToUrl(){
        if let comic = comic, let urls = comic.urls, !urls.isEmpty{
            if let stringUrl = urls[0].url, let url = URL(string: stringUrl){
                UIApplication.shared.open(url)
            }
        }
    }
    
    private func getAuthors(comic: Comic?) -> String{
        if let comic = comic, let creators = comic.creators, let authors = creators.items, !authors.isEmpty{
            var authorsString = ""
            for author in authors {
                if let name = author.name{
                    authorsString += "\(name), "
                }
            }
            return String(authorsString.prefix(authorsString.count - 2))
        } else {
            return DetailsPageConstants.noAuthor
        }
    }
}
