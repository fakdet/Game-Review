//
//  GameListViewModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation

class GameListViewModel{
    //MARK: This game array is temporary, will change later and be filled with API.
        private var games: [Game] = [

            Game(id: 1, title: "Sekiro: Shadows Die Twice", categoryIDs: [1, 9], rating: 9.5, status: .finished), // Action, Souls-Like

            Game(id: 2, title: "Elden Ring", categoryIDs: [1, 2, 9], rating: 10.0, status: .reviewed), // Action, RPG, Souls-Like

            Game(id: 3, title: "The Witcher 3: Wild Hunt", categoryIDs: [2], rating: 9.8, status: .reviewed), // RPG

            Game(id: 4, title: "Cyberpunk 2077", categoryIDs: [2, 1], rating: 8.5, status: .finished), // RPG, Action

            Game(id: 5, title: "Call of Duty: Modern Warfare", categoryIDs: [3], rating: 8.0, status: .finished), // Shooter

            Game(id: 6, title: "Counter-Strike 2", categoryIDs: [3], rating: nil, status: .playing), // Shooter

            Game(id: 7, title: "Forza Horizon 5", categoryIDs: [4], rating: 9.2, status: .finished), // Racing

            Game(id: 8, title: "Gran Turismo 7", categoryIDs: [4], rating: nil, status: .unplayed), // Racing

            Game(id: 9, title: "The Forest", categoryIDs: [5, 6], rating: 8.4, status: .finished), // Survival, Horror

            Game(id: 10, title: "Subnautica", categoryIDs: [5], rating: 9.0, status: .reviewed), // Survival

            Game(id: 11, title: "Resident Evil 4 Remake", categoryIDs: [6, 1], rating: 9.3, status: .reviewed), // Horror, Action

            Game(id: 12, title: "Outlast", categoryIDs: [6], rating: 8.7, status: .finished), // Horror

            Game(id: 13, title: "Portal 2", categoryIDs: [7], rating: 9.9, status: .reviewed), // Puzzle

            Game(id: 14, title: "The Witness", categoryIDs: [7], rating: nil, status: .unplayed), // Puzzle

            Game(id: 15, title: "Minecraft", categoryIDs: [8], rating: 9.6, status: .playing), // Sandbox

            Game(id: 16, title: "Terraria", categoryIDs: [8], rating: 9.1, status: .finished), // Sandbox

            Game(id: 17, title: "Final Fantasy VII Remake", categoryIDs: [2, 10], rating: 9.4, status: .reviewed), // RPG, JRPG

            Game(id: 18, title: "Persona 5 Royal", categoryIDs: [2, 10], rating: 9.7, status: .reviewed) // RPG, JRPG
        ]
    
    func numberOfItems() -> Int{
        return games.count
    }
    
    func game(at index: Int) -> Game{
        return games[index]
    }
    
    func title(for index:Int) -> String{
        return games[index].title
    }
    
}
