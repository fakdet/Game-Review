//
//  BaseViewModel.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 28.04.2026.
//

import Foundation

class BaseViewModel {
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?
    
    func handleResult<T>(_ result: Result<T, Error>, completion: @escaping (T) -> Void) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading?(false)
            switch result {
            case .success(let data):
                completion(data)
                self?.onDataUpdated?()
            
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
