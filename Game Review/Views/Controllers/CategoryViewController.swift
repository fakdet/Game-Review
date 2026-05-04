//
//  CategoryViewController.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//
import UIKit
import SnapKit
#if DEBUG
import netfox
#endif

class CategoryViewController: BaseViewController<CategoryListViewModel>{
    weak var coordinator: MainCoordinator?
    //MARK: UI elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Category.title
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .systemBackground
        cv.register(cellType: CategoryCell.self)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    #if DEBUG
    private lazy var debugButton: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "ladybug"),
                        style: .plain,
                        target: self,
                        action: #selector(openNetfox))
    }()
    #endif // DEBUG
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCategories()
        #if DEBUG
        navigationItem.rightBarButtonItem = debugButton
        #endif
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
    #if DEBUG
    //actions
    @objc private func openNetfox() {
        NFX.sharedInstance().show()
    }
    #endif // DEBUG
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let category = viewModel.category(at: indexPath.row) else {
            return cell
        }
        cell.configure(with: category.name, imageURL: category.imageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        viewModel.didSelectCategory(at: indexPath.item)
    }
}
