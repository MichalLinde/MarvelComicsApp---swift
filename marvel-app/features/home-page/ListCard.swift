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

        card.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        card.addSubviews(coverImageView, titleLabel, authorLabel, descriptionLabel)
        
        coverImageView.anchor(top: card.topAnchor, left: card.leftAnchor, bottom: card.bottomAnchor, paddingRight: 5, width: 120, height: 200)
        
        titleLabel.anchor(top: card.topAnchor, left: coverImageView.rightAnchor, right: card.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: frame.size.width / 2 )
        
        authorLabel.anchor(top: titleLabel.bottomAnchor, left: coverImageView.rightAnchor, right: card.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
        
        descriptionLabel.anchor(top: authorLabel.bottomAnchor, left: coverImageView.rightAnchor, right: card.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
    
        
    }
    
    private lazy var card: UIView = {
       let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 10.0
        card.layer.shadowColor = UIColor.gray.cgColor
        card.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        card.layer.shadowRadius = 6.0
        card.layer.shadowOpacity = 0.7
        return card
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Avengers #1 (2013), New Avengers #1 (2013), New Avengers #1 (2013)"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Written by Jonathan Hickman"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Ant-Man digs deeper into finding out who is leaking those dirty little secrets that are threatening our national security. And who's better at uncovering dirty LITTLE secrets than him??"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 4
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
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


