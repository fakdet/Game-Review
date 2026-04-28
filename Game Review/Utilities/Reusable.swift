//
//  Reusable.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 28.04.2026.
//

import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UICollectionViewCell: Reusable {}
