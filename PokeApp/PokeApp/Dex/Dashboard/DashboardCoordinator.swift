//
//  DashboardCoordinator.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import UIKit

class DashboardCoordinator: NSObject, Coordinator {
    private let window: UIWindow
    
    private lazy var dashboardViewModel = DashboardViewModel(pokeAPI: self.pokeAPI)
    
    private(set) var navigationController: UINavigationController?
    private(set) var childCoordinators: [Coordinator] = []
    
    private var pokeAPI = PokeAPI(pokeAPIService: PokeAPIService())
    
    init(window: UIWindow) {
        self.window = window
        super.init()
        start()
    }
    
    func start() {
        let dashboardViewController = DashboardViewController(viewModel: dashboardViewModel, coordinator: self)
        
        pokeAPI.register(stateListener: dashboardViewController)
        navigationController = UINavigationController(rootViewController: dashboardViewController)
        navigationController?.delegate = self
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func didSelectPokemon() {
        guard let navController = navigationController else {
            fatalError("Lost reference to Navigation Controller")
        }
        let detailCoordinator = PokemonDetailCoordinator(navigationController: navController, pokeAPI: pokeAPI)
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}

// This handles backwards navigation between coordinators sharing a common navigation controller
extension DashboardCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromController) {
            return
        }
        
        if let pkmnDetailViewController = fromController as? PokemonDetailViewController {
            childDidFinish(pkmnDetailViewController.coordinator)
        }
    }
}
