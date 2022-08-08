//
//  HomePageViewController.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import UIKit

class HomePageViewController: UITableViewController{
    
    var viewModel = HomePageViewModel()
    var comics: ComicDataWrapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.navigationItem.title = HomePageConstants.homePageTitle
        configureUI()
        
        Task{
            await fetchComics()
        }
    }
    
    private func configureUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ListCard.self, forCellReuseIdentifier: "\(HomePageConstants.cellId)")
        tableView.separatorStyle = .none        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comics?.data?.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomePageConstants.cellId)", for: indexPath) as? ListCard else {
            fatalError("\(HomePageConstants.cellError)")
        }
        
        cell.tag = indexPath.row
        
        let comicBook = comics?.data?.results?[indexPath.row]
        
        cell.titleLabel.text = comicBook?.getComicTitle(comic: comicBook)
        cell.authorLabel.text = comicBook?.getAuthor(comic: comicBook)
        cell.descriptionLabel.text = comicBook?.getDescription(comic: comicBook)
        
        cell.coverImageView.loadFrom(url: (comicBook?.getCoverUrl(comic: comicBook))! as URL)
        
        return cell
    }
    

    
    private func fetchComics() async {
        await viewModel.fetchComics()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension HomePageViewController: HomePageViewModelEvents{
    func comicsFetched(comics: ComicDataWrapper) {
        self.comics = comics
    }
}



