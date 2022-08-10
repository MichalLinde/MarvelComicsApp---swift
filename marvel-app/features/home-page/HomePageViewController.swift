//
//  HomePageViewController.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import UIKit

class HomePageViewController: UIViewController{
    
    var viewModel: HomePageViewModel
    
    init(viewModel: HomePageViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var comics: ComicDataWrapper?
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        
        configureUI()
        
        Task{
            self.startIndicator(indicator:indicator)
            await fetchComics()
        }
    }
    
    private func configureUI(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = HomePageConstants.homePageTitle
        self.navigationItem.backButtonDisplayMode = .minimal
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeTopAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeBottomAnchor,
                         right: view.rightAnchor)
        tableView.dataSource = self
        tableView.register(ListCard.self, forCellReuseIdentifier: "\(HomePageConstants.cellId)")
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private func fetchComics() async {
        await viewModel.fetchComics()
        DispatchQueue.main.async {
            self.stopIndicator(indicator: self.indicator)
            self.tableView.reloadData()
        }
    }
}

extension HomePageViewController: HomePageViewModelEvents{
    func comicsFetched(comics: ComicDataWrapper) {
        self.comics = comics
    }
}

extension HomePageViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comics?.data?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
}

extension HomePageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailsViewController(comic: comics?.data?.results?[indexPath.row]), animated: true)
    }
}



