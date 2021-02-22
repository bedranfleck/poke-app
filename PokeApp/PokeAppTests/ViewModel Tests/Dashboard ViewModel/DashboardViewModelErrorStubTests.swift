//
//  DashboardViewModelErrorStubTests.swift
//  PokeAppTests
//
//  Created by André Felipe Fleck Bedran on 22/02/21.
//

import XCTest
import Nimble

@testable import PokeApp

class DashboardViewModelErrorStubTests: XCTestCase {
    var viewModel: DashboardViewModel?
    var pokeAPI: PokeAPI?
    
    override func setUpWithError() throws {
        pokeAPI = PokeAPI(pokeAPIService: PokeAPIService(operationMode: .stubWithError(statusCode: 400, data: nil)))
        viewModel = DashboardViewModel(pokeAPI: pokeAPI)
    }

    override func tearDownWithError() throws {
        pokeAPI = nil
        viewModel = nil
    }

    func testNumberOfEntriesDidntIncreaseAfterErroneousFetch() {
        let startingNumber = viewModel?.entryCount()
        viewModel?.fetchNewDexPage()
        expect(startingNumber).toEventuallyNot(beLessThan(viewModel?.entryCount()), timeout: .seconds(2))
    }
    
    func testPokemonNumberIsNotReturnedWhenFetchedWithError() {
        viewModel?.fetchNewDexPage()
        let maxRange = viewModel!.entryCount()
        let randomEntry = Int.random(in: 0...maxRange)
        let number = viewModel?.dexNumberForEntry(randomEntry)
        expect(number).to(beNil())
    }
    
    func testPokemonNameIsNotCorrectlyReturnedWhenFetchedWithError() {
        viewModel?.fetchNewDexPage()
        let maxRange = viewModel!.entryCount()
        let randomEntry = Int.random(in: 0...maxRange)
        let name = viewModel?.pokemonName(with: randomEntry)
        expect(name).to(beNil())
    }
    
    func testEntryNumberIsCorrectlyReturnedWhenPokemonIsNotFetched() {
        viewModel?.fetchNewDexPage()
        let maxRange = viewModel!.entryCount()
        let randomEntry = Int.random(in: 0...maxRange)
        let entry = viewModel?.formattedEntryNumberText(randomEntry)
        expect(entry).to(contain("#\(randomEntry)"))
    }
    
    func testArtworkURLIsNotCorrectlyReturnedWhenFetchedWithError() {
        viewModel?.fetchNewDexPage()
        let maxRange = viewModel!.entryCount()
        let randomEntry = Int.random(in: 0...maxRange)
        let url = viewModel?.artworkURLForEntry(randomEntry)
        expect(url).to(beNil())
    }
}
