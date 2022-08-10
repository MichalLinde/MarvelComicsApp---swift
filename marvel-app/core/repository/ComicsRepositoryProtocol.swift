//
//  ComicsRepositoryProtocol.swift
//  marvel-app
//
//  Created by Michal on 10/08/2022.
//

import Foundation

protocol ComicsRepositoryProtocol {
    func fetchComic() async throws -> ComicDataWrapper
    
    func searchComics(searchText: String) async throws -> ComicDataWrapper
}
