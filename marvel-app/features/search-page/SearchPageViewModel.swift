//
//  SearchPageViewModel.swift
//  marvel-app
//
//  Created by Michal on 08/08/2022.
//

import Foundation

class SearchPageViewModel{
    
    let repo: ComicsRepositoryProtocol
    
    init(repo: ComicsRepositoryProtocol){
        self.repo = repo
    }
    
    var notFound = true
    weak var delegate: SearchPageViewModelEvents?
    
    func searchComics(searchText: String) async {
        do{
            let comics = try await repo.searchComics(searchText: searchText)
            self.delegate?.comicsFetched(comics: comics)
        } catch {
            print("Error fetching comics from viewmodel")
        }
    }
}
