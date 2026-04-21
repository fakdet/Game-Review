//
//  Game.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

struct Game{
    let id: Int
    var title: String
    var categoryIDs: [Int] //category link - Many - Many relation
    var rating: Double? // There can be no rating for a game at all. Needs to be handled.
    var status: GameStatus
    var publisher: String?
    var releaseDate: String?
    var review: Review?
}
