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
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No games were found based on your search results"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let progressBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
        
        if let category = category{
            title = category.name
            viewModel.filterGames(by: category)
        }
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFooter()
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
        view.addSubview(footerView)
        footerView.addSubview(footerLabel)
        footerView.addSubview(progressBar)
        
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
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -8),
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            footerView.heightAnchor.constraint(equalToConstant: 56),
            
            footerLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 8),
            footerLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            
            progressBar.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: 6),
            progressBar.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 12),
            progressBar.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -12),
            progressBar.heightAnchor.constraint(equalToConstant: 8),
            progressBar.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -8),
            
        ])
    }
    @objc private func filterButtonTapped(){
        let actionSheet = UIAlertController(title: "Filter By Status", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "All", style: .default) { _ in
            self.viewModel.filterByStatus(nil)
            self.updateTableView()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Unplayed", style: .default) { _ in
            self.viewModel.filterByStatus(.unplayed)
            self.updateTableView()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Playing", style: .default) { _ in
            self.viewModel.filterByStatus(.playing)
            self.updateTableView()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Finished", style: .default) { _ in
            self.viewModel.filterByStatus(.finished)
            self.updateTableView()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Reviewed", style: .default) { _ in
            self.viewModel.filterByStatus(.reviewed)
            self.updateTableView()
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    private func updateEmptyState() {
        tableView.backgroundView = viewModel.numberOfItems() == 0 ? emptyLabel : nil
    }
    
    private func updateFooter() {
        let total = viewModel.numberOfItems()
        let unplayed = viewModel.count(for: .unplayed)
        let playing = viewModel.count(for: .playing)
        let finished = viewModel.count(for: .finished)
        let reviewed = viewModel.count(for: .reviewed)
        
        footerLabel.text = "\(finished + reviewed)/\(total) Finished"
        
        //remove old segments
        progressBar.subviews.forEach { $0.removeFromSuperview() }

        guard total > 0 else { return }
        
        let segments: [(Int, UIColor)] = [
            (unplayed, .systemRed),
            (playing, .systemYellow),
            (finished, .systemBlue),
            (reviewed, .systemGreen)
        ]
        
        var currentX: CGFloat = 0
        let totalWidth = progressBar.bounds.width
        
        for (count, color) in segments {
            let width = (CGFloat(count) / CGFloat(total)) * totalWidth
            let segment = UIView(frame: CGRect(x: currentX, y: 0, width: width, height: 8))
            segment.backgroundColor = color
            progressBar.addSubview(segment)
            currentX += width
        }
    }
    
    private func updateTableView() {
        tableView.reloadData()
        updateEmptyState()
        updateFooter()
    }
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        let game = viewModel.game(at: indexPath.row)
        
        cell.configure(with: game) { [weak self] newStatus in
            self?.viewModel.changeStatus(of: game, to: newStatus)
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)  // ← only reload this row
            self?.updateFooter()
            self?.updateEmptyState()
        }
        
        return cell
    }
}

extension GameListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterGames(by: searchText)
        updateTableView()
    }
}
