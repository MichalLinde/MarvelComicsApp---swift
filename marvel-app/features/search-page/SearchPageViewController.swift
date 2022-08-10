//
//  SearchPageViewController.swift
//  marvel-app
//
//  Created by Michal on 05/08/2022.
//

import Foundation
import UIKit

class SearchPageViewController: UIViewController{
    
    var viewModel: SearchPageViewModel
    
    init(viewModel: SearchPageViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var comics: ComicDataWrapper?
    
    var debouncer: Timer?
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        setupUI()
    }
    
    private func setupUI(){
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.backButtonDisplayMode = .minimal
                
        navigationItem.titleView = searchBar
                
        view.addSubview(tableView)
        tableView.anchor(top: view.safeTopAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeBottomAnchor,
                         right: view.rightAnchor)
        tableView.dataSource = self
        tableView.register(ListCard.self, forCellReuseIdentifier: SearchPageConstants.cellId)
                
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

    
    //MARK: Views
    
    private var initialScreen = InitialScreenView()
    
    private var notFoundView = NothingFoundView()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.isHidden = true
        return table
    }()
    
    
    //MARK: Data
    
    func searchComics(searchText: String) async {
        await viewModel.searchComics(searchText: searchText)
        DispatchQueue.main.async {
            self.stopIndicator(indicator: self.indicator)
            self.tableView.reloadData()
        }
    }
}



extension SearchPageViewController: SearchPageViewModelEvents{

    func comicsFetched(comics: ComicDataWrapper) {
        self.comics = comics
    }
    
}



extension SearchPageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comics?.data?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPageConstants.cellId, for: indexPath) as? ListCard else {
            fatalError(SearchPageConstants.cellError)
        }
        
        cell.tag = indexPath.row
        
        let comicBook = comics?.data?.results?[indexPath.row]
        
        cell.titleLabel.text = comicBook?.getComicTitle(comic: comicBook)
        cell.authorLabel.text = comicBook?.getAuthor(comic: comicBook)
        cell.descriptionLabel.text = comicBook?.getDescription(comic: comicBook)
        
        cell.coverImageView.loadFrom(url: (comicBook?.getCoverUrl(comic: comicBook))! as URL)
        
        return cell
    }
}

extension SearchPageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailsViewController(comic: comics?.data?.results?[indexPath.row]), animated: true)
    }
}


extension SearchPageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = !searchText.isEmpty
        
        debouncer?.invalidate()
        debouncer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false){ _ in
            self.startIndicator(indicator: self.indicator)
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
                    notFoundView.notFoundText.text = "\(SearchPageConstants.notFoundText1) \(searchText) \(SearchPageConstants.notFoundText2)"
                    notFoundView.isHidden = false
                    tableView.isHidden = true
                }
            }
        } else {
            stopIndicator(indicator: indicator)
            initialScreen.isHidden = false
            notFoundView.isHidden = true
            tableView.isHidden = true
        }
    }
    
}
