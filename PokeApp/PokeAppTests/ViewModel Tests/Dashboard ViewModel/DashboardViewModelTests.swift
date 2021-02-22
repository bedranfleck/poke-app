//
//  DashboardViewModelTests.swift
//  PokeAppTests
//
//  Created by André Felipe Fleck Bedran on 22/02/21.
//

import XCTest
import Nimble

@testable import PokeApp

class DashboardViewModelTests: XCTestCase {
    var viewModel: DashboardViewModel?
    var pokeAPI: PokeAPI?
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI(pokeAPIService: PokeAPIService())
        viewModel = DashboardViewModel(pokeAPI: pokeAPI)
    }

    override func tearDownWithError() throws {
        pokeAPI = nil
        viewModel = nil
    }

    func testNumberOfEntriesIncreasedAfterSuccessfulFetch() {
        let startingNumber = viewModel?.entryCount()
        viewModel?.fetchNewDexPage()
        expect(startingNumber).toEventually(beLessThan(viewModel?.entryCount()), timeout: .seconds(2))
    }
    
    func testPokemonNumberIsCorrectlyReturnedWhenFetched() {
        viewModel?.fetchNewDexPage()
        let maxRange = viewModel!.entryCount() - 1
        let randomEntry = Int.random(in: 0...maxRange)
        let number = viewModel?.dexNumberForEntry(randomEntry)
        expect(number).toNot(beNil())
    }
    
    func testPokemonNameIsCorrectlyReturnedWhenFetched() {
        viewModel?.fetchNewDexPage()
        let maxRange = viewModel!.entryCount() - 1
        let randomEntry = Int.random(in: 0...maxRange)
        let name = viewModel?.pokemonName(with: randomEntry)
        expect(name).toNot(beNil())
    }
    
    func testEntryNumberIsCorrectlyReturnedWhenPokemonIsFetched() {
        viewModel?.fetchNewDexPage()
        let maxRange = viewModel!.entryCount() - 1
        let randomEntry = Int.random(in: 0...maxRange)
        let entry = viewModel?.formattedEntryNumberText(randomEntry)
        expect(entry).to(contain("#"))
        expect(entry?.count).to(beGreaterThan(1))
    }
    
    func testArtworkURLIsCorrectlyReturnedWhenFetched() {
        viewModel?.fetchNewDexPage()
        let maxRange = viewModel!.entryCount() - 1
        let randomEntry = Int.random(in: 0...maxRange)
        let url = viewModel?.artworkURLForEntry(randomEntry)
        expect(url).notTo(beNil())
        expect(url?.absoluteString).notTo(beNil()).notTo(beEmpty())
    }
}
