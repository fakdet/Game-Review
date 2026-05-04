//
//  CategoryListViewModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation

class CategoryListViewModel: BaseViewModel{
    private var categories: [Category] = []
    weak var coordinator: MainCoordinator?
    
    func fetchCategories() {
        isLoading?(true)
        
        NetworkManager.shared.request(endpoint: .genres) { [weak self] (result: Result<RAWGGenreResponse, Error>) in
            guard let self = self else { return }
            
            self.handleResult(result) { response in
                let mappedCategories = response.results.map {
                    Category(id: $0.id, name: $0.name, imageURL: $0.imageBackground)
                }
                self.categories = mappedCategories
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
    func didSelectCategory(at index: Int) {
        guard let selectedCategory = category(at: index) else { return }
        coordinator?.showGameList(for: selectedCategory)
    }
}
