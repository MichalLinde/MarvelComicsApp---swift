//
//  SearchPageViewModel.swift
//  marvel-app
//
//  Created by Michal on 08/08/2022.
//

import Foundation

class SearchPageViewModel {
    
    let repo = ComicsRepository()
    var notFound = true
    weak var delegate: SearchPageViewModelEvents?
    
    func searchComics(searchText: String) async {
        do{
            let comics = try await repo.searchComics(searchText: searchText)
            self.delegate?.comicsFetched(comics: comics)
            if let data = comics.data, let results = data.results{
                self.delegate?.nothingFound(notFound: results.isEmpty)
            } else{
                self.delegate?.nothingFound(notFound: true)
            }
        } catch {
            print("Error fetching comics from viewmodel")
        }
    }
}
