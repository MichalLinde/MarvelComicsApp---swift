//
//  DetailsViewController.swift
//  marvel-app
//
//  Created by Michal on 09/08/2022.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    var comic: Comic?
    var bottomSheet: BottomSheet?
    
    required init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = DetailsPageConstants.detailsPageTitle.localize()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let bottomSheet = bottomSheet {
            bottomSheet.dismiss(animated: true, completion: nil)
        }
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        
        view.addSubviews(backgroundImage)
        
        
        backgroundImage.anchor(top: view.safeTopAnchor,
                               left: view.leftAnchor,
                               bottom: view.safeBottomAnchor,
                               right: view.rightAnchor)
        backgroundImage.loadFrom(url: (comic?.getCoverUrl(comic: comic))! as URL)
        bottomSheet = BottomSheet(comic:comic)
        showBottomSheet(bottomSheet: bottomSheet)
        
    }
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    
    
    private func showBottomSheet(bottomSheet: BottomSheet?){
        if let bottomSheet = bottomSheet {
            bottomSheet.isModalInPresentation = true
            
            if let sheet = bottomSheet.sheetPresentationController{
                sheet.detents = [.medium(), .large()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = DetailsPageConstants.sheetCornerRadius
            }
            present(bottomSheet, animated: true)
        }
    }
}
