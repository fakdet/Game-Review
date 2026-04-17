//
//  CategoryListViewModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation

class CategoryListViewModel{
    //MARK: - This category array is temporary, will change later and be filled with API.
    private var categories: [Category] = [
        Category(id: 1, name: "Action"),
        Category(id: 2, name: "RPG"),
        Category(id: 3, name: "Shooter"),
        Category(id: 4, name: "Racing"),
        Category(id: 5, name: "Survival"),
        Category(id: 6, name: "Horror"),
        Category(id: 7, name: "Puzzle"),
        Category(id: 8, name: "Sandbox"),
        Category(id: 9, name: "Souls-Like"),
        Category(id: 10, name: "J-RPG"),
    ]
    
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
