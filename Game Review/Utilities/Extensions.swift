//
//  Extensions.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 29.04.2026.
//

import UIKit

// MARK: - Reusable Protocol
protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UICollectionReusableView: Reusable {}

// MARK: - UICollectionView Extensions
extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Cell was not able to be created: \(T.identifier)")
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: T.identifier)
    }
}

// MARK: - UITableView Extensions
extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Cell was not able to be created: \(T.identifier)")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: T.identifier)
    }
}

// MARK: - UIView Extensions
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

// MARK: - UITextField Extensions
extension UITextField {
    var doubleValue: Double {
        return Double(self.text ?? "") ?? 0.0
    }
}

// MARK: - Double Extensions
extension Double {
    var ratingString: String {
        return String(format: "%.1f", self)
    }
}
