//
//  SearchPageViewModelEvents.swift
//  marvel-app
//
//  Created by Michal on 08/08/2022.
//

import Foundation

protocol SearchPageViewModelEvents: AnyObject {
    func comicsFetched(comics: ComicDataWrapper)
    func nothingFound(notFound: Bool)
}
