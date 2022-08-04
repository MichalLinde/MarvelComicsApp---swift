//
//  ComicsRepository.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import Foundation

class ComicsRepository{
    
    let apiClient = ApiClient()
    
    func fetchComic() async throws -> ComicDataWrapper{
        
        do {
            let data = try await apiClient.fetchComics()
            
            let comicDataWrapper = try JSONDecoder().decode(ComicDataWrapper.self, from: data)
            
            return comicDataWrapper
        } catch {
            throw FetchingError.failedFetching(message: "Failed in Repo")
        }
    }
}
