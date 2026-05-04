//
//  MainCoordinator.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 4.05.2026.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let viewModel = CategoryListViewModel()
        viewModel.coordinator = self
        let vc = CategoryViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    func showGameList(for category: Category) {
        let viewModel = GameListViewModel(category: category)
        viewModel.coordinator = self
        let vc = GameListViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    func showGameDetail(for game: Game, delegate: GameDetailDelegate?) {
        let viewModel = GameDetailViewModel(game: game)
        viewModel.coordinator = self
        let vc = GameDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
