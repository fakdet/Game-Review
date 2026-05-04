//
//  GameListViewModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation

class GameListViewModel: BaseViewModel{
    private let category: Category
    weak var coordinator: MainCoordinator?
    private var allGames: [Game] = []
    private var filteredGames: [Game] = []
    
    var categoryName: String {
            return category.name
        }
    //MARK: - init
    init(category: Category){
        self.category = category
        super.init()
    }
    func fetchGames() {
        isLoading?(true)
        
        NetworkManager.shared.request(endpoint: .games(genreId: category.id)) { [weak self] (result: Result<RAWGGameResponse, Error>) in
            guard let self = self else { return }
            
            self.handleResult(result) { response in
                let mappedGames = response.results.map { apiGame -> Game in
                    var game = Game(
                        id: apiGame.id,
                        title: apiGame.name,
                        categoryIDs: apiGame.genres.map { $0.id },
                        rating: nil,
                        status: .unplayed,
                        publisher: apiGame.publishers?.first?.name,
                        releaseDate: apiGame.released,
                        review: nil,
                        imageURL: apiGame.backgroundImage
                    )
                    if let local = RealmManager.shared.getLocalData(for: game.id) {
                        game.status = GameStatus(rawValue: local.status) ?? .unplayed
                        
                        if let lr = local.review {
                            game.review = Review(
                                graphics: lr.graphics,
                                soundDesign: lr.soundDesign,
                                artDesign: lr.artDesign,
                                gameplay: lr.gameplay,
                                story: lr.story,
                                overallRating: lr.overallRating,
                                text: lr.text
                            )
                            game.rating = lr.overallRating
                        }
                    }
                    return game
                }
                
                self.allGames = mappedGames
                self.filteredGames = mappedGames
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
    
    func filterGames(by searchText: String){
        filteredGames = allGames.filter { $0.categoryIDs.contains(category.id) }
        if !searchText.isEmpty{
            filteredGames = filteredGames.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        onDataUpdated?()
    }
    
    func filterByStatus(_ status: GameStatus?){
        if let status = status {
            filteredGames = allGames.filter {
                $0.categoryIDs.contains(category.id) && $0.status == status
            }
        } else {
            //status variable can be null, this just means it will show all.
            filteredGames = allGames
        }
        onDataUpdated?()
    }
    
    func count(for status: GameStatus) -> Int{
        return filteredGames.filter { $0.status == status }.count
    }
    
    func changeStatus(of game: Game, to newStatus: GameStatus) {
        guard let index = allGames.firstIndex(where: { $0.id == game.id }) else { return }
        
        var updatedGame = allGames[index]
        updatedGame.status = newStatus
        
        if newStatus != .reviewed {
            updatedGame.rating = nil
        }
        
        allGames[index] = updatedGame
        
        RealmManager.shared.saveGameData(
            id: updatedGame.id,
            status: newStatus,
            review: updatedGame.review
        )
        
        filteredGames = allGames.filter { $0.categoryIDs.contains(category.id) }
        onDataUpdated?()
    }
    
    func didSelectGame(at index: Int, delegate: GameDetailDelegate) {
        let selectedGame = game(at: index)
        coordinator?.showGameDetail(for: selectedGame, delegate: delegate)
    }
    
    func updateGame(_ updatedGame: Game) {
        guard let index = allGames.firstIndex(where: { $0.id == updatedGame.id }) else { return }
        allGames[index] = updatedGame
        filteredGames = allGames.filter { $0.categoryIDs.contains(category.id) }
        onDataUpdated?()
    }

}
