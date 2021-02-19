//
//  EnvironmentTests.swift
//  PokeAppTests
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import XCTest
import Nimble

@testable import PokeApp

class EnvironmentTests: XCTestCase {
    
    func testDexURLIsValid() {
        let dexURL = Environment.dexBaseURL
        expect(dexURL).to(beAKindOf(URL.self))
        expect(dexURL?.path).toNot(beNil())
        expect(dexURL?.absoluteString).to(contain(Configuration.value(for: .dexBaseURL)))
    }
    
    func testArtworkURLIsValid() {
        let artworkURL = Environment.artworkBaseURL
        expect(artworkURL).to(beAKindOf(URL.self))
        expect(artworkURL?.path).toNot(beNil())
        expect(artworkURL?.absoluteString).to(contain(Configuration.value(for: .artworkBaseURL)))
    }

}
