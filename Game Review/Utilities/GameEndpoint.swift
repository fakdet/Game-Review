//
//  Untitled.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 28.04.2026.
//

import Foundation

enum GameEndpoint {
    case genres
    case games(genreId: Int)
    case detail(gameId: Int)
    
    var path: String{
        switch self{
        case .genres: return "/genres"
        case .games: return "/games"
        case .detail(let id): return "/games/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem(name: "key", value: API.key)]
        switch self {
        case .games(let genreId):
            items.append(URLQueryItem(name: "genres", value: "\(genreId)"))
            items.append(URLQueryItem(name: "page_size", value: "20"))
        default:
            break
        }
        return items
    }
    
    var url: URL? {
        var components = URLComponents(string: API.baseURL + path)
        components?.queryItems = queryItems
        return components?.url
    }
}
