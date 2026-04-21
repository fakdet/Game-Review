//
//  GameListViewController.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation
import UIKit

class GameListViewController: UIViewController {
    
    //MARK: Properties
    private let viewModel = GameListViewModel()
    var category: Category?
    
    //MARK: UI elements
    
    //I want a search bar, filter and a sort button. and then a table view
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for a game"
        return searchBar
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        if let category = category{
            title = category.name
            viewModel.filterGames(by: category)
        }
        setupUI()
    }
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .systemBackground
        tv.register(GameCell.self, forCellReuseIdentifier: "GameCell")
        tv.delegate = self
        tv.dataSource = self
        
        return tv
    }()
    
    private func setupUI()
    {
        view.addSubview(searchBar)
        view.addSubview(filterButton)
        view.addSubview(tableView)
        
        tableView.backgroundColor = .systemGray6
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            filterButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }   
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.configure(with: viewModel.game(at: indexPath.row))
        
        return cell
    }
}
