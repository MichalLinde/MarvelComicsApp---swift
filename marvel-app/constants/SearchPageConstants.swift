//
//  SearchPageConstants.swift
//  marvel-app
//
//  Created by Michal on 08/08/2022.
//

import Foundation
import UIKit

struct SearchPageConstants {
    //MARK: Dimens
    static let infoTextPadding: CGFloat = 10.0
    static let initialImageHeight: CGFloat = 120.0
    static let initialImageWidth: CGFloat = 200.0
    static let notFoundImageHeight: CGFloat = 200.0
    static let notFoundImageWidth: CGFloat = 200.0
    static let initialTextSize = 18.0
    static let notFoundTextSize = 18.0
    
    //MARK: Strings
    static let initialText = "Start typing to find a particular comics."
    static let searchBarHint = "Search for a comic book"
    static let cellId = "ComicsCell"
    static let cellError = "ListCard is not defined"
    static let baseImageUrl = "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"
    static let noTitle = "Title unknown."
    static let noAuthor = "Author unknown."
    static let noDescription = "No description was given"
    static let writtenBy = "Written by"
    static let createdBy = "Created by"
    static let notFoundText1 = "There is not comic book"
    static let notFoundText2 = "in our library. Check the spelling and try again."
    
}
