//
//  ListCard.swift
//  marvel-app
//
//  Created by Michal on 02/08/2022.
//

import Foundation
import UIKit
import SwiftUI

#if DEBUG
struct ThisViewPreview: PreviewProvider{
    static var previews: some View {
        ListCard().showPreview()
    }
}
#endif

class ListCard: UITableViewCell{
    static let identifier = "ListCard"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImageView.image = nil
    }
    
    func setupLayout(){
        self.addSubview(card)

        card.anchor(top: self.topAnchor,
                    left: self.leftAnchor,
                    bottom: self.bottomAnchor,
                    right: self.rightAnchor,
                    paddingTop: TableConstants.tableItemPadding,
                    paddingLeft: TableConstants.tableItemPadding,
                    paddingBottom: TableConstants.tableItemPadding,
                    paddingRight: TableConstants.tableItemPadding,
                    height: TableConstants.tableItemHeight)
        
        card.addSubviews(imageContainer, titleLabel, authorLabel, descriptionLabel)
        
        imageContainer.anchor(top: card.topAnchor,
                              left: card.leftAnchor,
                              bottom: card.bottomAnchor,
                              paddingRight: TableConstants.betweenTextPadding,
                              width: TableConstants.imageWidth)
        
        titleLabel.anchor(top: card.topAnchor,
                          left: coverImageView.rightAnchor,
                          right: card.rightAnchor,
                          paddingTop: TableConstants.betweenTextPadding,
                          paddingLeft: TableConstants.betweenTextPadding,
                          paddingBottom: TableConstants.betweenTextPadding,
                          paddingRight: TableConstants.betweenTextPadding)
        
        authorLabel.anchor(top: titleLabel.bottomAnchor,
                           left: coverImageView.rightAnchor,
                           right: card.rightAnchor,
                           paddingTop: TableConstants.betweenTextPadding,
                           paddingLeft: TableConstants.betweenTextPadding,
                           paddingBottom: TableConstants.betweenTextPadding,
                           paddingRight: TableConstants.betweenTextPadding)
        
        descriptionLabel.anchor(top: authorLabel.bottomAnchor,
                                left: coverImageView.rightAnchor,
                                right: card.rightAnchor,
                                paddingTop: TableConstants.betweenTextPadding,
                                paddingLeft: TableConstants.betweenTextPadding,
                                paddingBottom: TableConstants.betweenTextPadding,
                                paddingRight: TableConstants.betweenTextPadding)
    
        
    }
    
    private lazy var card: UIView = {
       let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = TableConstants.cornerRadius
        card.layer.shadowColor = UIColor.gray.cgColor
        card.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        card.layer.shadowRadius = TableConstants.cardShadowRadius
        card.layer.shadowOpacity = TableConstants.cardShadowOpacity
        return card
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: TableConstants.titleFontSize, weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: TableConstants.authorFontSize)
        label.textColor = .gray
        label.numberOfLines = .zero
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: TableConstants.descriptionFontSize)
        label.textColor = .black
        label.numberOfLines = TableConstants.descriptionLinesNumber
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var imageContainer: UIView = {
        let container = UIView()
        container.addSubview(coverImageView)
        coverImageView.anchor(top: container.topAnchor,
                              left: container.leftAnchor,
                              bottom: container.bottomAnchor,
                              right: container.rightAnchor)
        return container
    }()
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = TableConstants.cornerRadius
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
}

extension UIImageView {
    func loadFrom(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIView{
    private struct Preview: UIViewRepresentable {
        let view: UIView
        
        func makeUIView(context: Context) -> UIView {
            return view
        }
                
        func updateUIView(_ uiView: UIView, context: Context) {}
    }
    
    func showPreview() -> some View {
            Preview(view: self)
        }
}


