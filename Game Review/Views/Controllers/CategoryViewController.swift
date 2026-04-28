//
//  CategoryViewController.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//
import UIKit
import SnapKit

class CategoryViewController: BaseViewController<CategoryListViewModel>{
    //MARK: UI elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Game Categories"
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell") // extension
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCategories()
    }
    
    override func setupUI()
    {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
        setupCollectionViewLayout()
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        viewModel.onDataUpdated  = { [weak self] in
            self?.collectionView.reloadData()
        }
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
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell // Extension
        guard let category = viewModel.category(at: indexPath.row) else {
            return cell
        }
        cell.configure(with: category.name, imageURL: category.imageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        guard let category = viewModel.category(at: indexPath.item) else { return }
        let gameListVM = GameListViewModel(category: category)
        let vc = GameListViewController(viewModel: gameListVM)
        navigationController?.pushViewController(vc, animated: true)
    }
}
