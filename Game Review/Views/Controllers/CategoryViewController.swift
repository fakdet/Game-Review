//
//  CategoryViewController.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//
import Foundation
import UIKit

class CategoryViewController: UIViewController{
    
    //MARK: Properties
    private let viewModel = CategoryListViewModel()
    
    //MARK: UI elements
    //Just the title on top of the collection view.
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false // This is needed for some reason
        label.text = "Game Categories"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupCollectionViewLayout()
        
        bindViewModel()
        viewModel.fetchCategories()
    }
    
    private func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let safeWidth = view.safeAreaLayoutGuide.layoutFrame.width
        let cellWidth = (safeWidth - 48) / 2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    
    private func setupUI()
    {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated  = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.onError = { error in
            print("Error!: \(error)")
        }
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = viewModel.category(at: indexPath.row)
        
        cell.configure(with: category.name, imageURL: category.imageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let category = viewModel.category(at: indexPath.item)
        let vc = GameListViewController()
        vc.category = category
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

