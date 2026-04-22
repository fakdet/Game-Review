//
//  CategoryListViewModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation

class CategoryListViewModel{
    //MARK: - This category array is temporary, will change later and be filled with API.
    private var categories: [Category] = []
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchCategories() {
        NetworkManager.shared.fetchGenres { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self?.categories = categories
                    self?.onDataUpdated?()
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func numberOfItems() -> Int {
        return categories.count
    }
    
    func category(at index: Int) -> Category {
        return categories[index]
    }
    
    func title(for index: Int) -> String {
        return categories[index].name
    }
}
