//
//  ConfigurationTests.swift
//  PokeAppTests
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import XCTest
import Nimble

@testable import PokeApp

class ConfigurationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDexBaseURLIsAccessible() {
        let dexBaseURL = Configuration.value(for: .dexBaseURL)
        expect(dexBaseURL).notTo(beEmpty())
    }

    func testArtworkBaseURLIsAccessible() {
        let artworkBaseURL = Configuration.value(for: .artworkBaseURL)
        expect(artworkBaseURL).notTo(beEmpty())
    }
    
    func testConfigurationProducesValidDescription() {
        let confDescription = Configuration().description
        expect(confDescription).to(beginWith("["))
        expect(confDescription).to(endWith("]"))
        for key in Configuration.Keys.allCases {
            expect(confDescription).to(contain(key.rawValue))
            expect(confDescription).to(contain(":"))
            expect(confDescription).to(contain(Configuration.value(for: key)))
            
        }
    }
}
