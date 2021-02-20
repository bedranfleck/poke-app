//
//  DashboardCoordinator.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import UIKit

class DashboardCoordinator: Coordinator {
    private let window: UIWindow
    private var dashboardViewModel = DashboardViewModel()
    private var rootViewController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
        start()
    }
    
    func start() {
        let dashboardViewController = DashboardViewController(viewModel: dashboardViewModel)
        rootViewController = UINavigationController(rootViewController: dashboardViewController)
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
}
