//
//  GameStatus.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import Foundation
enum GameStatus: String, Codable, CaseIterable {
    case unplayed
    case playing
    case finished
    case reviewed
    
    //For the labels
    var title: String {
        "gamestatus.\(rawValue)".localized
    }
    
    //For the dropdown menu
    var icon: String {
        switch self {
        case .unplayed: return "circle"
        case .playing:  return "play.circle"
        case .finished: return "checkmark.circle"
        case .reviewed: return "star.circle"
        }
    }

    static var filterOptions: [(title: String, status: GameStatus?)] {
        [("All", nil)] + GameStatus.allCases.map { ($0.title, $0) }
    }
}
