//
//  Game.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

struct Game: Codable{
    let id: Int
    var title: String
    var categoryIDs: [Int] //category link - Many - Many relation
    var rating: Double?
    var status: GameStatus
    var publisher: String?
    var releaseDate: String?
    var review: Review?
    var imageURL: String?
}

extension Game {
    var safeReview: (graphics: Double, sound: Double, art: Double, gameplay: Double, story: Double, overall: Double, text: String) {
        return (
                    graphics: review?.graphics ?? 0,
                    sound: review?.soundDesign ?? 0,
                    art: review?.artDesign ?? 0,
                    gameplay: review?.gameplay ?? 0,
                    story: review?.story ?? 0,
                    overall: review?.overallRating ?? 0,
                    text: review?.text ?? ""
                )
    }
}
