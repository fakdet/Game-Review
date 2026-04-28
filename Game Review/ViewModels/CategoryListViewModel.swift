//
//  CategoryListViewModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation

class CategoryListViewModel: BaseViewModel{
    private var categories: [Category] = []
    
    func fetchCategories() {
        isLoading?(true)
        NetworkManager.shared.fetchGenres { [weak self] result in
            self?.handleResult(result) { categories in
                self?.categories = categories
            }
        }
    }
    
    func numberOfItems() -> Int {
        return categories.count
    }
    func category(at index: Int) -> Category? {
        return categories[index]
    }
    func title(for index: Int) -> String {
        return categories[index].name
    }
    func imageURL(for index: Int) -> String? {
        return categories[index].imageURL
    }
}
