//
//  HomePageViewModelProtocol.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import Foundation

protocol HomePageViewModelProtocol: AnyObject {
    //var comics: ComicDataWrapper { get }
    var comicsDidChange: ((HomePageViewModelProtocol) -> ())? { get set }
    init(repo: ComicsRepository)
    func fetchComic() async
}
