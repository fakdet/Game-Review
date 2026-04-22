//
//  LocalGameData.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 22.04.2026.
//

import Foundation
import RealmSwift

class LocalGameData: Object {
    @Persisted(primaryKey: true) var id: Int //API Game ID
    @Persisted var status: String = "unplayed"
    @Persisted var review: LocalReview?
}

class LocalReview: Object {
    @Persisted var graphics: Double = 0.0
    @Persisted var soundDesign: Double = 0.0
    @Persisted var artDesign: Double = 0.0
    @Persisted var gameplay: Double = 0.0
    @Persisted var story: Double = 0.0
    @Persisted var overallRating: Double = 0.0
    @Persisted var text: String = ""
}
