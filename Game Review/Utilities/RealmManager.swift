//
//  RealmManager.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 22.04.2026.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    private let realm = try! Realm()
    
    func saveGameData(id: Int, status: GameStatus, review: Review?) {
        let localData = LocalGameData()
        localData.id = id
        localData.status = status.rawValue
        
        if let r = review {
            let lr = LocalReview()
            lr.graphics = r.graphics
            lr.soundDesign = r.soundDesign
            lr.artDesign = r.artDesign
            lr.gameplay = r.gameplay
            lr.story = r.story
            lr.overallRating = r.overallRating
            lr.text = r.text
            localData.review = lr
        }
        
        try? realm.write {
            realm.add(localData, update: .modified)
        }
    }
    
    func getLocalData(for id: Int) -> LocalGameData? {
        return realm.object(ofType: LocalGameData.self, forPrimaryKey: id)
    }
}
