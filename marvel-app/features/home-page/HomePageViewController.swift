//
//  HomePageViewController.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import UIKit

class HomePageViewController: UITableViewController, HomePageViewModelEvents{
    
    var viewModel = HomePageViewModel()
    var comics: ComicDataWrapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        configureUI()
        
        Task{
            await fetchComics()
        }
    }
    
    private func configureUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Marvel Comics"
        
        tableView.register(ListCard.self, forCellReuseIdentifier: "ComicsCell")
        tableView.separatorStyle = .none        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableConstants.tableItemHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comics?.data?.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsCell", for: indexPath) as? ListCard else {
            fatalError("ListCard is not defined")
        }
        
        cell.tag = indexPath.row
        
        let comicBook = comics?.data?.results?[indexPath.row]
        
        cell.titleLabel.text = getComicTitle(comic: comicBook)
        cell.authorLabel.text = getAuthor(comic: comicBook)
        cell.descriptionLabel.text = getDescription(comic: comicBook)
        
        cell.coverImageView.loadFrom(url: getCoverUrl(comic: comicBook))
        
        return cell
    }
    

    
    private func fetchComics() async {
        await viewModel.fetchComics()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func getComicTitle(comic: Comic?) -> String{
        if let comic = comic, let title = comic.title{
            return title
        } else{
            return "Title unknown."
        }
    }
    
    private func getAuthor(comic: Comic?) -> String{
        if let comic = comic, let creators = comic.creators, let items = creators.items, !items.isEmpty{
            for author in items {
                if (author.role == "writer"){
                    return "Written by \(author.name ?? "???")."
                }
            }
            return "Created by \(items[0].name ?? "???")."
        } else{
            return "Author unknown."
        }
    }
    
    private func getDescription(comic: Comic?) -> String{
        if let comic = comic, let description = comic.description, !description.isEmpty{
            return description
        } else{
            return "No description was given."
        }
    }
    
    private func getCoverUrl(comic: Comic?) -> URL{
        guard let defaultUrl = URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")else {
            return URL(string:"")!
        }
        
        if let comic = comic, let thumbnail = comic.thumbnail, let path = thumbnail.path, let ext = thumbnail.extension {
            return URL(string: "\(path).\(ext)".replacingOccurrences(of: "http", with: "https")) ?? defaultUrl
        } else {
            return defaultUrl
        }
    }
}

extension HomePageViewController{
    func comicsFetched(comics: ComicDataWrapper) {
        self.comics = comics
    }
}



