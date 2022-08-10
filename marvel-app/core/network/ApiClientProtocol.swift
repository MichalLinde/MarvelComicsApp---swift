//
//  ApiClientProtocol.swift
//  marvel-app
//
//  Created by Michal on 10/08/2022.
//

import Foundation

protocol ApiClientProtocol {
    func fetchComics() async throws -> Data
    
    func searchComics(searchText: String) async throws -> Data
}
