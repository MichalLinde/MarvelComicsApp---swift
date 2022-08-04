//
//  HomePageViewModel.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import Foundation

class HomePageViewModel{
    
    let repo = ComicsRepository()
    weak var delegate: HomePageViewModelEvents?
    
    func fetchComics() async {
        do {
            self.delegate?.comicsFetched(comics: try await repo.fetchComic())
        } catch{
            print("Error fetching data in viewmodel")
        }
    }
    
}
