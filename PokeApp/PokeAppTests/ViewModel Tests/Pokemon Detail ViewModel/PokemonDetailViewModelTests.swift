//
//  PokemonDetailViewModelTests.swift
//  PokeAppTests
//
//  Created by André Felipe Fleck Bedran on 22/02/21.
//

import XCTest
import Nimble

@testable import PokeApp

class PokemonDetailViewModelTests: XCTestCase {
    var viewModel: PokemonDetailViewModel?
    var pokeAPI: PokeAPI?
    var listener: StateListener!
    
    override func setUpWithError() throws {
        listener = StateListener()
        pokeAPI = PokeAPI(pokeAPIService: PokeAPIService())
        
        //This is set to 12 to match the stub file.
        viewModel = PokemonDetailViewModel(dexNumber: 12, pokeAPI: pokeAPI!)
    }

    override func tearDownWithError() throws {
        pokeAPI = nil
        viewModel = nil
    }
    
    func testStateChangesAreBroadcast() {
        viewModel?.delegate = listener
        viewModel?.fetchPokemon()
        expect(self.listener.state).notTo(beNil())
    }
    
    func testSectionsAreReturnedAccordingToFetchStatus() {
        let initialNumberOfSections = viewModel?.numberOfSections()
        viewModel?.fetchPokemon()
        expect(initialNumberOfSections).toEventually(beLessThan(viewModel?.numberOfSections()), timeout: .seconds(2))
    }
    
    func testEmptyStateTypeIsNotReturnedOnSuccess() {
        let idleEmptyState = viewModel?.emptyStateType()
        viewModel?.fetchPokemon()
        let successEmptyState = viewModel?.emptyStateType()
        expect(idleEmptyState).toEventually(beNil())
        expect(successEmptyState).toEventually(beNil())
    }
    
    func testPokemonNameReturnsCorrectly() {
        viewModel?.fetchPokemon()
        expect(self.viewModel?.pokemonName()).notTo(beNil())
    }
    
    func testAtLeastDefaultPokemonSpriteReturnCorrectly() {
        viewModel?.fetchPokemon()
        let defaultSprite = viewModel?.normalSpriteURL()
        expect(defaultSprite).notTo(beNil())
    }
    
    func testAtLeastOneTypeIsReturned() {
        viewModel?.fetchPokemon()
        let typeOne = viewModel?.pokemonPrimaryType()
        expect(typeOne).notTo(beNil())
    }
    
    func testAtLeastOneAbilityIsReturned() {
        viewModel?.fetchPokemon()
        let ability = viewModel?.firstAbilityName()
        expect(ability).notTo(beNil()).notTo(beEmpty())
    }
    
    func testBaseStatsAreReturned() {
        viewModel?.fetchPokemon()
        let hp = viewModel?.pokemonHPStat()
        let atk = viewModel?.pokemonAtkStat()
        let def = viewModel?.pokemonDefStat()
        let spAtk = viewModel?.pokemonSpAtkStat()
        let spDef = viewModel?.pokemonSpDefStat()
        let speed = viewModel?.pokemonSpeedStat()
        
        expect(hp).notTo(beNil()).notTo(beEmpty())
        expect(atk).notTo(beNil()).notTo(beEmpty())
        expect(def).notTo(beNil()).notTo(beEmpty())
        expect(spAtk).notTo(beNil()).notTo(beEmpty())
        expect(spDef).notTo(beNil()).notTo(beEmpty())
        expect(speed).notTo(beNil()).notTo(beEmpty())
    }
    
    //Mock Listener object specification
    class StateListener: PokemonDetailViewModelDelegate {
        private(set) var state: PokemonDetailViewModel.State?
        
        func viewModelDidUpdateState(newState: PokemonDetailViewModel.State) {
            self.state = newState
        }
    }
}

