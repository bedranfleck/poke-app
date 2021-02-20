//
//  DashboardCoordinator.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import UIKit

class DashboardCoordinator: Coordinator {
    private let window: UIWindow
    private lazy var dashboardViewModel = DashboardViewModel(pokeAPI: self.pokeAPI)
    private var rootViewController: UINavigationController?
    private var pokeAPI = PokeAPI(pokeAPIService: PokeAPIService())
    
    init(window: UIWindow) {
        self.window = window
        start()
    }
    
    func start() {
        let dashboardViewController = DashboardViewController(viewModel: dashboardViewModel)
        pokeAPI.register(stateListener: dashboardViewController)
        rootViewController = UINavigationController(rootViewController: dashboardViewController)
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
}
