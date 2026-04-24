//
//  NetworkManager.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 22.04.2026.
//

import Foundation

class NetworkManager {
    
    //MARK: - Singleton
    static let shared = NetworkManager()
    private init() {}
    
    func fetchGenres(completion: @escaping (Result<[Category], Error>) -> Void) {
        let urlString = "\(API.baseURL)/genres?key=\(API.key)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(RAWGGenreResponse.self, from: data)
                let categories = decoded.results.map {
                    Category(id: $0.id, name: $0.name, imageURL: $0.imageBackground)
                }
                completion(.success(categories))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchGames(genreID: Int, completion: @escaping (Result<[Game], Error>) -> Void) {
        let urlString = "\(API.baseURL)/games?key=\(API.key)&genres=\(genreID)&page_size=20"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(RAWGGameResponse.self, from: data)
                let games = decoded.results.map { rawgGame -> Game in
                    Game(
                        id: rawgGame.id,
                        title: rawgGame.name,
                        categoryIDs: rawgGame.genres.map { $0.id },
                        rating: nil,
                        status: .unplayed,
                        publisher: rawgGame.publishers?.first?.name,
                        releaseDate: rawgGame.released,
                        review: nil,
                        imageURL: rawgGame.backgroundImage
                    )
                }
                completion(.success(games))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchGameDetail(id: Int, completion: @escaping (String?) -> Void) {
        let urlString = "\(API.baseURL)/games/\(id)?key=\(API.key)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { completion(nil); return }
            
            if let json = try? JSONDecoder().decode(RAWGGameDetail.self, from: data) {
                completion(json.publishers?.first?.name)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
