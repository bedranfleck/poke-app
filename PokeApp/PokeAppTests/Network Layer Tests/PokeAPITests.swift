//
//  PokeAPITests.swift
//  PokeAppTests
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import XCTest
import Nimble

@testable import PokeApp

class PokeAPITests: XCTestCase {
    
    class PokeAPIMockListener: PokeAPIObserver {
        var didUpdate = false
        func pokeAPIDidUpdateState(_ state: PokeAPI.State) {
            didUpdate = true
        }
    }
    
    var pokeAPI: PokeAPI?

    //This will init PokeAPIService in stub mode, which is the general case for these Unit Tests. Refer to `BaseService.swift`
    override func setUpWithError() throws {
        pokeAPI = PokeAPI(pokeAPIService: PokeAPIService())
    }

    override func tearDownWithError() throws {
        pokeAPI = nil
    }
    
    func testObserversAreNotifiedOfStateChanges() {
        let mockListener = PokeAPIMockListener()
        pokeAPI?.register(stateListener: mockListener)
        pokeAPI?.fetchPokemon(with: Int.random(in: 0...600), completion: {_ in })
        expect(mockListener.didUpdate).toEventually(beTrue())
    }
    
    func testRemovedObserversStopReceivingStateChanges() {
        let mockListener = PokeAPIMockListener()
        pokeAPI?.register(stateListener: mockListener)
        pokeAPI?.deregister(stateListener: mockListener)
        pokeAPI?.fetchDexPage(completion: {_ in })
        expect(mockListener.didUpdate).toNotEventually(beTrue())
    }
    
    func testFetchPokemonSuccessfully() {
        var butterfree: Pokemon?
        pokeAPI?.fetchPokemon(with: Int.random(in: 0...600), completion: { (pokemon) in
            butterfree = pokemon
        })
        expect(butterfree).toEventuallyNot(beNil())
    }
    
    func testFetchPokemonSuccessfullyWithNetworkResponseDelay() {
        var butterfree: Pokemon?
        
        //For this particular case we force a delay in the stub closure
        pokeAPI = PokeAPI(pokeAPIService: PokeAPIService(operationMode: .stubWithDelay(delay: Double.random(in: 0...3))))
        
        pokeAPI?.fetchPokemon(with: Int.random(in: 0...600), completion: { (pokemon) in
            butterfree = pokemon
        })
        expect(butterfree).toEventuallyNot(beNil(), timeout: .seconds(3))
    }
    
    func testPokemonFetchReturnsNilValuesWhenErrorsAreThrown() {
        var butterfree: Pokemon?
        
        //For this particular case we force an error in the stub closure
        pokeAPI = PokeAPI(pokeAPIService: PokeAPIService(operationMode: .stubWithError(statusCode: Int.random(in: 300...900), data: nil)))
        
        pokeAPI?.fetchPokemon(with: Int.random(in: 0...600), completion: { (pokemon) in
            butterfree = pokemon
        })
        expect(butterfree).toEventually(beNil(), timeout: .seconds(3))
    }
    
    func testFetchDexPageSuccessfully() {
        var pokemonInfos: [PokemonBasicInfo]?
        
        pokeAPI?.fetchDexPage(completion: { (pokemonInfo) in
            pokemonInfos = pokemonInfo
        })
        expect(pokemonInfos).toEventuallyNot(beNil())
        expect(pokemonInfos).toEventuallyNot(beEmpty())
    }
    
    func testFetchDexPageSuccessfullyWithNetworkResponseDelay() {
        var pokemonInfos: [PokemonBasicInfo]?
        
        //For this particular case we force a delay in the stub closure
        pokeAPI = PokeAPI(pokeAPIService: PokeAPIService(operationMode: .stubWithDelay(delay: Double.random(in: 0...3))))
        
        pokeAPI?.fetchDexPage(completion: { (pokemonInfo) in
            pokemonInfos = pokemonInfo
        })
        expect(pokemonInfos).toEventuallyNot(beNil(), timeout: .seconds(3))
        expect(pokemonInfos).toEventuallyNot(beEmpty(), timeout: .seconds(3))
    }
    
    func testFetchDexPageReturnsNilValuesWhenErrorsAreThrown() {
        var pokemonInfos: [PokemonBasicInfo]?
        
        //For this particular case we force an error in the stub closure
        pokeAPI = PokeAPI(pokeAPIService: PokeAPIService(operationMode: .stubWithError(statusCode: Int.random(in: 300...900), data: nil)))
        
        pokeAPI?.fetchDexPage(completion: { (pokemonInfo) in
            pokemonInfos = pokemonInfo
        })
        expect(pokemonInfos).toEventually(beNil())
    }

}
