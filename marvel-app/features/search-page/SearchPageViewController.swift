//
//  SearchPageViewController.swift
//  marvel-app
//
//  Created by Michal on 05/08/2022.
//

import Foundation
import UIKit

class SearchPageViewController: UIViewController{
    
    private var viewModel = SearchPageViewModel()
    var comics: ComicDataWrapper?
    var notFound: Bool?
    
    var debouncer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        setupUI()
    }
    
    private func setupUI(){
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
                
        navigationItem.titleView = searchBar
                
        view.addSubview(tableView)
        tableView.anchor(top: view.safeTopAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeBottomAnchor,
                         right: view.rightAnchor)
        tableView.dataSource = self
        tableView.register(ListCard.self, forCellReuseIdentifier: "ComicsCell")
        
        view.addSubview(initialScreen)
        initialScreen.anchor(top: view.safeTopAnchor,
                             left: view.leftAnchor,
                             bottom: view.safeBottomAnchor,
                             right: view.rightAnchor)
        
        view.addSubview(notFoundView)
        notFoundView.anchor(top: view.safeTopAnchor,
                             left: view.leftAnchor,
                             bottom: view.safeBottomAnchor,
                             right: view.rightAnchor)
        
    }
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = SearchPageConstants.searchBarHint
        bar.delegate = self
        bar.sizeToFit()
        bar.searchTextField.clearButtonMode = .never
        bar.tintColor = .red
        return bar
    }()

    
    //VIEWS
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.isHidden = true
        return table
    }()
    
    private lazy var initialScreen: UIView = {
        let view = UIView()
        view.addSubviews(initialText, initialImage)
        view.isHidden = false
        
        initialImage.center(inView: view)
        
        initialText.anchor(top: initialImage.bottomAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingLeft: SearchPageConstants.infoTextPadding,
                           paddingRight: SearchPageConstants.infoTextPadding)
        return view
    }()
    
    private lazy var initialText: UILabel = {
        let label = UILabel()
        label.text = SearchPageConstants.initialText
        label.font = .systemFont(ofSize: SearchPageConstants.initialTextSize, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var initialImage: UIImageView = {
        let image = UIImage(systemName: "book.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.setHeight(SearchPageConstants.initialImageHeight)
        imageView.setWidth(SearchPageConstants.initialImageWidth)
        return imageView
    }()
    
    private lazy var notFoundView: UIView = {
        let view = UIView()
        view.addSubviews(notFoundText, notFoundImage)
        view.isHidden = true
        
        notFoundImage.center(inView: view)
        
        notFoundText.anchor(top: notFoundImage.bottomAnchor,
                            left: view.leftAnchor,
                            right: view.rightAnchor,
                            paddingLeft: SearchPageConstants.infoTextPadding,
                            paddingRight: SearchPageConstants.infoTextPadding)
        return view
    }()
    
    private lazy var notFoundText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: SearchPageConstants.notFoundTextSize, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var notFoundImage: UIImageView = {
        let image = UIImage(systemName: "xmark.circle.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.setHeight(SearchPageConstants.notFoundImageHeight)
        imageView.setWidth(SearchPageConstants.notFoundImageWidth)
        return imageView
    }()
    
    
    
    //UTILS
    
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
    
    //DATA
    
    func searchComics(searchText: String) async {
        await viewModel.searchComics(searchText: searchText)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}



extension SearchPageViewController: SearchPageViewModelEvents{

    func comicsFetched(comics: ComicDataWrapper) {
        self.comics = comics
    }
    
    func nothingFound(notFound: Bool) {
        self.notFound = notFound
    }
}



extension SearchPageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comics?.data?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
}

extension SearchPageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = !searchText.isEmpty
        
        debouncer?.invalidate()
        debouncer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false){ _ in
            self.fetchComicsOnChange(searchText: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        notFoundView.isHidden = true
        tableView.isHidden = true
        initialScreen.isHidden = false
        searchBar.showsCancelButton = false
    }
    
    func fetchComicsOnChange(searchText: String){
        
        if !searchText.isEmpty {
            Task{
                await searchComics(searchText: searchText)
                if let comics = comics, let data = comics.data, let results = data.results, !results.isEmpty {
                    initialScreen.isHidden = true
                    notFoundView.isHidden = true
                    tableView.isHidden = false
                } else{
                    initialScreen.isHidden = true
                    notFoundText.text = "There is not comic book \(searchText) in our library. Check the spelling and try again."
                    notFoundView.isHidden = false
                    tableView.isHidden = true
                }
            }
        } else {
            initialScreen.isHidden = false
            notFoundView.isHidden = true
            tableView.isHidden = true
        }
    }
    
}
