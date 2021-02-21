//
//  PokemonDetailCoordinator.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import UIKit

class PokemonDetailCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private(set) var navigationController: UINavigationController?
    
    private var pokemonDetailViewModel: PokemonDetailViewModel!
    
    init(navigationController: UINavigationController, pokeAPI: PokeAPI, dexNumber: Int) {
        self.navigationController = navigationController
        self.pokemonDetailViewModel = PokemonDetailViewModel(dexNumber: dexNumber, pokeAPI: pokeAPI)
    }
    
    func start() {
        let detailViewController = PokemonDetailViewController(viewModel: pokemonDetailViewModel, coordinator: self)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}


