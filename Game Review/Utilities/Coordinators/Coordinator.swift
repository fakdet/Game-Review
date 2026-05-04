//
//  Coordinator.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 4.05.2026.
//

import UIKit

protocol Coordinator : AnyObject {
    var navigationController: UINavigationController { get set }
    func start()    
}
