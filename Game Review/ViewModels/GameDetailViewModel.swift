//
//  GameDetailViewModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 21.04.2026.
//

import Foundation

class GameDetailViewModel {
    private(set) var game: Game
    
    init(game: Game){
        self.game = game
    }
    
    //MARK: - Information
    var title: String { game.title }
    var publisher: String{ game.publisher ?? "Unknown"}
    var releaseDate: String{ game.releaseDate ?? "Unknown"}
    var hasReview: Bool { game.review != nil }
    
    var status: String {
        switch game.status {
        case .unplayed: return "Unplayed"
        case .playing: return "Playing"
        case .finished: return "Finished"
        case .reviewed: return "Reviewed"
        }
    }
    
    var categoryNames: String {
        return "Action, RPG" // Temporary - will connect to categories later on
    }
    
    //MARK: - Review
    var graphics: Double    { game.review?.graphics ?? 0 }
    var soundDesign: Double { game.review?.soundDesign ?? 0 }
    var artDesign: Double   { game.review?.artDesign ?? 0 }
    var gameplay: Double    { game.review?.gameplay ?? 0 }
    var story: Double       { game.review?.story ?? 0 }
    var overallRating: Double { game.review?.overallRating ?? 0 }
    var reviewText: String  { game.review?.text ?? "" }
    
    func saveReview(graphics: Double, soundDesign: Double, artDesign: Double,
                    gameplay: Double, story: Double, overall: Double, text: String) {
        game.review = Review(
            graphics: graphics,
            soundDesign: soundDesign,
            artDesign: artDesign,
            gameplay: gameplay,
            story: story,
            overallRating: overall,
            text: text
        )
        game.status = .reviewed
        game.rating = overall
    }
    
}
