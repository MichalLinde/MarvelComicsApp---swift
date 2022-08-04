//
//  HomePageViewModelEvents.swift
//  marvel-app
//
//  Created by Michal on 02/08/2022.
//

import Foundation

protocol HomePageViewModelEvents: AnyObject {
    func comicsFetched(comics: ComicDataWrapper)
}
