//
//  NetworkManager.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 22.04.2026.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(endpoint: GameEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        let url = API.baseURL + endpoint.path
        
        AF.request(url,
                   method: .get,
                   parameters: endpoint.parameters)
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
