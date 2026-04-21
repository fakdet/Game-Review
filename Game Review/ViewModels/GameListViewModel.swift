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
    private var games: [Game] = [
        Game(id: 1, title: "Sekiro: Shadows Die Twice", categoryIDs: [1, 9], rating: nil, status: .finished,
             publisher: "FromSoftware", releaseDate: "March 22, 2019"),              // Action, Souls-Like

        Game(id: 2, title: "Elden Ring", categoryIDs: [1, 2, 9], rating: 10.0, status: .reviewed,
             publisher: "FromSoftware", releaseDate: "February 25, 2022"),           // Action, RPG, Souls-Like

        Game(id: 3, title: "The Witcher 3: Wild Hunt", categoryIDs: [2], rating: 9.8, status: .reviewed,
             publisher: "CD Projekt Red", releaseDate: "May 19, 2015"),              // RPG

        Game(id: 4, title: "Cyberpunk 2077", categoryIDs: [2, 1], rating: nil, status: .finished,
             publisher: "CD Projekt Red", releaseDate: "December 10, 2020"),         // RPG, Action

        Game(id: 5, title: "Call of Duty: Modern Warfare", categoryIDs: [3], rating: nil, status: .finished,
             publisher: "Activision", releaseDate: "October 25, 2019"),              // Shooter

        Game(id: 6, title: "Counter-Strike 2", categoryIDs: [3], rating: nil, status: .playing,
             publisher: "Valve", releaseDate: "September 27, 2023"),                 // Shooter

        Game(id: 7, title: "Forza Horizon 5", categoryIDs: [4], rating: nil, status: .finished,
             publisher: "Xbox Game Studios", releaseDate: "November 9, 2021"),       // Racing

        Game(id: 8, title: "Gran Turismo 7", categoryIDs: [4], rating: nil, status: .unplayed,
             publisher: "Sony Interactive", releaseDate: "March 4, 2022"),           // Racing

        Game(id: 9, title: "The Forest", categoryIDs: [5, 6], rating: nil, status: .finished,
             publisher: "Endnight Games", releaseDate: "May 30, 2018"),              // Survival, Horror

        Game(id: 10, title: "Subnautica", categoryIDs: [5], rating: 9.0, status: .reviewed,
             publisher: "Unknown Worlds", releaseDate: "January 23, 2018"),          // Survival

        Game(id: 11, title: "Resident Evil 4 Remake", categoryIDs: [6, 1], rating: 9.3, status: .reviewed,
             publisher: "Capcom", releaseDate: "March 24, 2023"),                    // Horror, Action

        Game(id: 12, title: "Outlast", categoryIDs: [6], rating: nil, status: .finished,
             publisher: "Red Barrels", releaseDate: "September 4, 2013"),            // Horror

        Game(id: 13, title: "Portal 2", categoryIDs: [7], rating: 9.9, status: .reviewed,
             publisher: "Valve", releaseDate: "April 19, 2011"),                     // Puzzle

        Game(id: 14, title: "The Witness", categoryIDs: [7], rating: nil, status: .unplayed,
             publisher: "Thekla Inc.", releaseDate: "January 26, 2016"),             // Puzzle

        Game(id: 15, title: "Minecraft", categoryIDs: [8], rating: nil, status: .playing,
             publisher: "Mojang Studios", releaseDate: "November 18, 2011"),         // Sandbox

        Game(id: 16, title: "Terraria", categoryIDs: [8], rating: nil, status: .finished,
             publisher: "Re-Logic", releaseDate: "May 16, 2011"),                    // Sandbox

        Game(id: 17, title: "Final Fantasy VII Remake", categoryIDs: [2, 10], rating: 9.4, status: .reviewed,
             publisher: "Square Enix", releaseDate: "April 10, 2020"),               // RPG, J-RPG

        Game(id: 18, title: "Persona 5 Royal", categoryIDs: [2, 10], rating: 9.7, status: .reviewed,
             publisher: "Atlus", releaseDate: "October 31, 2019")                    // RPG, J-RPG
    ]
    
    private var filteredGames: [Game] = []
    
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
        filteredGames = games.filter { $0.categoryIDs.contains(category.id) }
    }
    
    func filterGames(by searchText: String){
        filteredGames = games.filter { $0.categoryIDs.contains(currentCategory?.id ?? -1) }
        if !searchText.isEmpty{
            filteredGames = filteredGames.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func filterByStatus(_ status: GameStatus?){
        if let status = status {
            filteredGames = games.filter {
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
        guard let index = games.firstIndex(where: { $0.id == game.id }) else { return }
        
        var updatedGame = games[index]
        
        updatedGame = Game(
            id: updatedGame.id,
            title: updatedGame.title,
            categoryIDs: updatedGame.categoryIDs,
            rating: updatedGame.status == .reviewed ? nil : updatedGame.rating,  // delete rating if was reviewed
            status: newStatus
        )
        
        games[index] = updatedGame
        
        if let category = currentCategory {
            filterGames(by: category)
        }
    }
    
}
