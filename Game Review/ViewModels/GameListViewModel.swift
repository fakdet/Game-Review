//
//  GameListViewModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation

class GameListViewModel{
    private var currentCategory: Category?
    //MARK: This game array is temporary, will change later and be filled with API.
    private var allGames: [Game] = []
    private var filteredGames: [Game] = []
    
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchGames(for category: Category) {
        currentCategory = category
        NetworkManager.shared.fetchGames(genreID: category.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    self?.allGames = games
                    self?.filteredGames = games
                    self?.onDataUpdated?()
                    
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func numberOfItems() -> Int{
        return filteredGames.count
    }
    
    func game(at index: Int) -> Game{
        return filteredGames[index]
    }
    
    func title(for index:Int) -> String{
        return filteredGames[index].title
    }
    
    func filterGames(by category: Category){
        currentCategory = category
        filteredGames = allGames.filter { $0.categoryIDs.contains(category.id) }
    }
    
    func filterGames(by searchText: String){
        filteredGames = allGames.filter { $0.categoryIDs.contains(currentCategory?.id ?? -1) }
        if !searchText.isEmpty{
            filteredGames = filteredGames.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func filterByStatus(_ status: GameStatus?){
        if let status = status {
            filteredGames = allGames.filter {
                $0.categoryIDs.contains(currentCategory?.id ?? -1) &&
                $0.status == status
            }
        } else {
            //status variable can be null, this just means it will show all.
            filterGames(by: currentCategory!)
        }
    }
    
    func count(for status: GameStatus) -> Int{
        return filteredGames.filter { $0.status == status }.count
    }
    
    func changeStatus(of game: Game, to newStatus: GameStatus) {
        guard let index = allGames.firstIndex(where: { $0.id == game.id }) else { return }
        
        var updatedGame = allGames[index]
        updatedGame = Game(
            id: updatedGame.id,
            title: updatedGame.title,
            categoryIDs: updatedGame.categoryIDs,
            rating: updatedGame.status == .reviewed ? nil : updatedGame.rating,
            status: newStatus,
            publisher: updatedGame.publisher,
            releaseDate: updatedGame.releaseDate,
            review: updatedGame.review
        )
        
        allGames[index] = updatedGame
        filterGames(by: currentCategory ?? Category(id: -1, name: ""))
    }
    
}
