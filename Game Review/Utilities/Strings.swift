//
//  Strings.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 29.04.2026.
//

enum L10n {
    enum Category {
        static let title = "category.title".localized
    }
    enum GameList {
        static let searchPlaceholder = "gamelist.search_placeholder".localized
        static let filterButton = "gamelist.filter_button".localized
        static let filterTitle = "gamelist.filter_title".localized
        static let empty = "gamelist.empty".localized
        static let finished = "gamelist.finished".localized
        static let error = "gamelist.error".localized
    }
    enum GameCell {
        static let changeStatus = "gamecell.change_status".localized
    }
    enum GameDetail {
        static let publisher = "gamedetail.publisher".localized
        static let releaseDate = "gamedetail.release_date".localized
        static let status = "gamedetail.status".localized
        static let review = "gamedetail.review".localized
        static let edit = "gamedetail.edit".localized
        static let cancel = "gamedetail.cancel".localized
        static let save = "gamedetail.save".localized
        static let graphics = "gamedetail.graphics".localized
        static let sound = "gamedetail.sound".localized
        static let art = "gamedetail.art".localized
        static let gameplay = "gamedetail.gameplay".localized
        static let story = "gamedetail.story".localized
        static let overall = "gamedetail.overall".localized
        static let reviewPlaceholder = "gamedetail.review_placeholder".localized
    }
    enum GameStatus {
        static let filterAll = "gamestatus.filter_all".localized
    }
}
