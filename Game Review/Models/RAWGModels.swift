//
//  RAWGModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 22.04.2026.
//

import Foundation

nonisolated struct RAWGGenreResponse: Codable, Sendable {
    let results: [RAWGGenre]
}

nonisolated struct RAWGGenre: Codable, Sendable {
    let id: Int
    let name: String
    let imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageBackground = "image_background"
    }

}

nonisolated struct RAWGGameResponse: Codable, Sendable {
    let results: [RAWGGame]
}

struct RAWGGame: Codable, Sendable {
    let id: Int
    let name: String
    let released: String?
    let backgroundImage: String?
    let genres: [RAWGGenre]
    let publishers: [RAWGPublisher]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case genres
        case publishers
    }
}

struct RAWGPublisher: Codable, Sendable {
    let name: String
}

nonisolated struct RAWGGameDetail: Codable, Sendable {
    let publishers: [RAWGPublisher]?
}
