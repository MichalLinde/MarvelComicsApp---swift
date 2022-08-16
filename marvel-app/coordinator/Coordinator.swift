//
//  Coordinator.swift
//  marvel-app
//
//  Created by Michal on 11/08/2022.
//

import Foundation
import UIKit

enum Event {
    case listElementClicked(comic: Comic?)
}

protocol Coordinator{
    var navigationController: UINavigationController? { get set }
    
    func eventOccured(with type: Event)
    
    func start() -> UINavigationController
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

