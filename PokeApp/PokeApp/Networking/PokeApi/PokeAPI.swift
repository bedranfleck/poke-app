//
//  PokeApi.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import Foundation

protocol PokeAPIObserver {
    func pokeAPIDidUpdateState(_ state: PokeAPI.State)
}

protocol PokeAPISubject {
    func register(stateListener: PokeAPIObserver)
    func deregister(stateListener: PokeAPIObserver)
}

/// API class to perform requests using Moya providers.
/// This is meant to serve as a facade to access a number of different REST APIs under the same context.
/// Internal state changes are communicated to listeners via a multicast delegate that works together with two protocols to implement an Observer pattern.
/// Any fetch results are returned in the scope of a closure.
class PokeAPI {
    private var pokeAPIService: PokeAPIService
    private var dexPaginationStatus: DexPaginationStatus = .hasNextPage(nextPageNumber: 0)
    private var stateListeners = MulticastDelegate<PokeAPIObserver>()
    
    private var state: State = .idle(error: nil) {
        didSet {
            broadcastStateChange()
        }
    }
    
    init(pokeAPIService: PokeAPIService) {
        self.pokeAPIService = pokeAPIService
    }
    
    private func nextPageNumber() -> Int? {
        switch self.dexPaginationStatus {
        case .hasNextPage(let pageNumber):
            return pageNumber
        case .endReached:
            return nil
        }
    }
    
    /// Fetches a page with basic pokémon info from PokeApi.co
    /// - Parameter completion: A closure containing an optional array of `PokemonBasicInfo` within its scope
    func fetchDexPage(completion: @escaping ([PokemonBasicInfo]?) -> Void) {
        self.state = .loadingDex
        
        guard let pageNumber = nextPageNumber() else {
            completion(nil)
            self.state = .idle(error: .noPagesAvailable)
            return
        }
        
        pokeAPIService.fetchDexPage(number: pageNumber) { (dexPage, error) in
            if error != nil {
                let networkError = NetworkError.from(error)
                self.state = .idle(error: networkError)
                completion(nil)
            } else {
                guard let page = dexPage, let pokemon = dexPage?.results else {
                    self.state = .idle(error: .noPagesAvailable)
                    completion(nil)
                    return
                }
                
                if page.hasNextPage() {
                    let nextPage = pageNumber + 1
                    self.dexPaginationStatus = .hasNextPage(nextPageNumber: nextPage)
                }
                
                self.state = .idle(error: nil)
                completion(pokemon)
            }
        }
    }
    
    /// Fetches a single Pokémon from PokeApi.co
    /// - Parameters:
    ///   - nationalID: The Pokémon id according to the National Dex
    ///   - completion: A closure containing an optional Pokemon data type
    func fetchPokemon(with nationalID: Int, completion: @escaping (Pokemon?) -> Void) {
        self.state = .loadingPokemon
        
        pokeAPIService.fetchPokemon(by: nationalID) { (pokemon, error) in
            if error != nil {
                let networkError = NetworkError.from(error)
                self.state = .idle(error: networkError)
                completion(nil)
            } else {
                guard let result = pokemon else {
                    self.state = .idle(error: .unknownError)
                    completion(nil)
                    return
                }
                self.state = .idle(error: nil)
                completion(result)
            }
        }
    }
    
}

// MARK: - State Management
extension PokeAPI: PokeAPISubject {
    enum DexPaginationStatus {
        case hasNextPage(nextPageNumber: Int)
        case endReached
    }
    
    enum State {
        case loadingDex
        case loadingPokemon
        case idle(error: NetworkError?)
    }
    
    private func broadcastStateChange() {
        stateListeners |> { listener in
            listener.pokeAPIDidUpdateState(self.state)
        }
    }
    
    func register(stateListener: PokeAPIObserver) {
        stateListeners.addDelegate(stateListener)
    }
    
    func deregister(stateListener: PokeAPIObserver) {
        stateListeners.removeDelegate(stateListener)
    }
}
