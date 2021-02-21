//
//  PokemonDetailViewModel.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import Foundation

protocol PokemonDetailViewModelDelegate: class {
    func viewModelDidUpdateState()
}

class PokemonDetailViewModel: ViewModel {
    
    enum State {
        case loading
        case loadSuccess
        case loadError
    }
    
    enum CellType {
        case name
        case sprites
        case types
        case abilities
        case weightAndHeight
        case stats
    }
    
    private let pokemonDexNumber: Int
    private let pokeAPI: PokeAPI
    private var pokemon: Pokemon?
    weak var delegate: PokemonDetailViewModelDelegate?
    
    private var sections: [CellType] = []
    
    private var state: State? {
        didSet {
            buildViewState()
        }
    }
    
    init(dexNumber: Int, pokeAPI: PokeAPI) {
        self.pokemonDexNumber = dexNumber
        self.pokeAPI = pokeAPI
        self.pokeAPI.register(stateListener: self)
    }
    
    func fetchPokemon() {
        pokeAPI.fetchPokemon(with: pokemonDexNumber) {[weak self] (pokemon) in
            guard let pokemon = pokemon else {
                return
            }
            self?.pokemon = pokemon
            self?.state = .loadSuccess
        }
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func cellType(for row: Int) -> CellType {
        guard row < sections.count else {
            fatalError("Index out of range")
        }
        return sections[row]
    }
    
    func emptyStateType() -> EmptyStateViewType {
        switch state {
        case .loading:
            return .loading
        case .loadError:
            return .error
        default:
            return .none
        }
    }
    
    private func buildViewState() {
        switch state {
        case .loading, .loadError:
            sections = []
        default:
            sections = [.name,
                        .sprites,
                        .types,
                        .abilities,
                        .weightAndHeight,
                        .stats]
        }
        updateView()
    }
    
    private func updateView() {
        delegate?.viewModelDidUpdateState()
    }
    
}

extension PokemonDetailViewModel: PokeAPIObserver {
    func pokeAPIDidUpdateState(_ state: PokeAPI.State) {
        switch state {
        case .idle(let error):
            if error != nil {
                self.state = .loadError
            }
        case .loadingPokemon:
            self.state = .loading
        default:
            break
        }
    }
    
}
