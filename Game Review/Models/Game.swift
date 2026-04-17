//
//  Game.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

struct Game{
    let id: Int
    let title: String
    let categoryIDs: [Int] //category link - Many - Many relation
    
    let rating: Double? // There can be no rating for a game at all. Needs to be handled.
    let status: GameStatus
}
