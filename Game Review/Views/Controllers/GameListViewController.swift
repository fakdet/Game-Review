//
//  GameListViewController.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation
import UIKit
import SnapKit

class GameListViewController: BaseViewController<GameListViewModel> {
    
    //MARK: UI elements
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a game"
        searchBar.delegate = self
        return searchBar
    }()
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.backgroundColor = .systemBackground
        tv.register(GameCell.self, forCellReuseIdentifier: "GameCell") // Extension
        tv.backgroundColor = .systemGray6
        tv.layer.cornerRadius = 10
        tv.clipsToBounds = true
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No games were found based on your search results"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    private lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    private lazy var progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.categoryName
        viewModel.fetchGames()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateFooter()
    }
    //MARK: - Setup
    override func setupUI()
    {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(filterButton)
        view.addSubview(tableView)
        view.addSubview(footerView)
        footerView.addSubview(footerLabel)
        footerView.addSubview(progressBar)
    }
    override func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(footerView.snp.top).offset(-8)
        }
        
        footerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.height.equalTo(56)
        }
        
        footerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(footerLabel.snp.bottom).offset(6)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: - Binding
    override func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.updateTableView()
        }
        viewModel.onError = { error in
            print("Error!: \(error)")
        }
    }
    
    //MARK: - UI Logic
    private func updateTableView() {
        tableView.reloadData()
        updateEmptyState()
        updateFooter()
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
    
    //MARK: - Actions
    @objc private func filterButtonTapped(){
        let actionSheet = UIAlertController(title: "Filter By Status", message: nil, preferredStyle: .actionSheet)
        let filterOptions: [(String, GameStatus?)] = [
                    ("All", nil),
                    ("Unplayed", .unplayed),
                    ("Playing", .playing),
                    ("Finished", .finished),
                    ("Reviewed", .reviewed)
                ]
        
        for option in filterOptions {
            actionSheet.addAction(UIAlertAction(title: option.0, style: .default) { _ in
                self.viewModel.filterByStatus(option.1)
                self.updateTableView()
            })
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
}

extension GameListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell // Extension
        let game = viewModel.game(at: indexPath.row)
        
        cell.configure(with: game) { [weak self] newStatus in
            guard let self = self else { return }
            self.viewModel.changeStatus(of: game, to: newStatus)
            
            if let existingCell = self.tableView.cellForRow(at: indexPath) as? GameCell {
                existingCell.updateStatusOnly(to: newStatus)
            }
            self.updateFooter()
            self.updateEmptyState()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let game = viewModel.game(at: indexPath.row)
        
        let detailVM = GameDetailViewModel(game: game)
        let detailVC = GameDetailViewController(viewModel: detailVM)
        
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension GameListViewController: GameDetailDelegate{
    func didUpdateGame(_ game: Game) {
        viewModel.updateGame(game)
        updateTableView()
    }
}

extension GameListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterGames(by: searchText)
        updateTableView()
    }
}
