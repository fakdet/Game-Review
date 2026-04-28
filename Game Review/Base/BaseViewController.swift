//
//  BaseViewController.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 28.04.2026.
//

import UIKit
import SnapKit

class BaseViewController<T: BaseViewModel>: UIViewController {
    //MARK: - Properties
    let viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
        bindBaseViewModel()
        bindViewModel()
    }
    
    func setupUI() {}
    func setupConstraints() {}
    func bindViewModel() {}
    private func bindBaseViewModel() {
        viewModel.onError = { [weak self] errorMessage in
            self?.showErrorAlert(message: errorMessage)
        }
        viewModel.isLoading = { [weak self] loading in
            self?.handleLoadingState(loading)
        }
    }
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    private func handleLoadingState(_ loading: Bool) {
        //TO-DO add loading spiral
    }
}
