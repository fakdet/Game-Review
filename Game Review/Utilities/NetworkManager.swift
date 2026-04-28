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
    
    func request<T: Decodable>(endpoint: GameEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(NSError(domain: "Invalid Url", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
