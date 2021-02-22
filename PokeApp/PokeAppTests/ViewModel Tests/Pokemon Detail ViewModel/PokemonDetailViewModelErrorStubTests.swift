//
//  PokemonDetailViewModelErrorStubTests.swift
//  PokeAppTests
//
//  Created by André Felipe Fleck Bedran on 22/02/21.
//

import XCTest
import Nimble

@testable import PokeApp

class PokemonDetailViewModelErrorStubTests: XCTestCase {
    var viewModel: PokemonDetailViewModel?
    var pokeAPI: PokeAPI?
    var listener: StateListener!
    
    override func setUpWithError() throws {
        listener = StateListener()
        pokeAPI = PokeAPI(pokeAPIService: PokeAPIService(operationMode: .stubWithError(statusCode: 400, data: nil)))
        
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
        expect(initialNumberOfSections).toEventuallyNot(beLessThan(viewModel?.numberOfSections()), timeout: .seconds(2))
    }
    
    func testEmptyStateTypeIsReturnedOnError() {
        let idleEmptyState = viewModel?.emptyStateType()
        viewModel?.fetchPokemon()
        let errorState = viewModel?.emptyStateType()
        expect(idleEmptyState).toEventually(beNil())
        expect(errorState).toEventuallyNot(beNil())
    }
    
    func testPokemonNameReturnsCorrectly() {
        viewModel?.fetchPokemon()
        expect(self.viewModel?.pokemonName()).to(beNil())
    }
    
    func testPokemonSpritesReturnCorrectly() {
        viewModel?.fetchPokemon()
        let defaultSprite = viewModel?.normalSpriteURL()
        let shinySprite = viewModel?.shinySpriteURL()
        expect(defaultSprite).to(beNil())
        expect(shinySprite).to(beNil())
    }
    
    func testNoTypesAreReturned() {
        viewModel?.fetchPokemon()
        let typeOne = viewModel?.pokemonPrimaryType()
        let typeTwo = viewModel?.pokemonSecondaryType()
        expect(typeOne).to(beNil())
        expect(typeTwo).to(beNil())
    }
    
    func testNoAbilitiesAreReturned() {
        viewModel?.fetchPokemon()
        let abilityOne = viewModel?.firstAbilityName()
        let abilityTwo = viewModel?.secondAbilityName()
        expect(abilityOne).to(beNil())
        expect(abilityTwo).to(beNil())
    }
    
    func testBaseStatsAreNotReturned() {
        viewModel?.fetchPokemon()
        let hp = viewModel?.pokemonHPStat()
        let atk = viewModel?.pokemonAtkStat()
        let def = viewModel?.pokemonDefStat()
        let spAtk = viewModel?.pokemonSpAtkStat()
        let spDef = viewModel?.pokemonSpDefStat()
        let speed = viewModel?.pokemonSpeedStat()
        
        expect(hp).to(beNil())
        expect(atk).to(beNil())
        expect(def).to(beNil())
        expect(spAtk).to(beNil())
        expect(spDef).to(beNil())
        expect(speed).to(beNil())
    }
    
    //Mock Listener object specification
    class StateListener: PokemonDetailViewModelDelegate {
        private(set) var state: PokemonDetailViewModel.State?
        
        func viewModelDidUpdateState(newState: PokemonDetailViewModel.State) {
            self.state = newState
        }
    }
}
