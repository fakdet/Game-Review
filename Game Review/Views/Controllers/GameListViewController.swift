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
    
    //MARK: UI elements
    
    //I want a search bar, filter and a sort button. and then a table view
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a game"
        return searchBar
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
    }
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        
        return cell
    }
}
