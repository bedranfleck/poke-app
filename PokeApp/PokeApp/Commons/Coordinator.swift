//
//  Coordinator.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController? { get }
    var childCoordinators: [Coordinator] { get }
    func start()
}
