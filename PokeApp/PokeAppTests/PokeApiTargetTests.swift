//
//  PokeApiTargetTests.swift
//  PokeAppTests
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import XCTest
import Nimble
import Moya

@testable import PokeApp

class PokeApiTargetTests: XCTestCase {
    var pageTarget: PokeAPITarget?
    var pkmnTarget: PokeAPITarget?
    var pkmnNumber: Int?
    var pageNumber: Int?
    
    override func setUpWithError() throws {
        pkmnNumber = Int.random(in: 1...600)
        pageNumber = Int.random(in: 0...30)
        //I'm only force-unwrapping these because I know for sure Int.random(:) is not Optional
        pageTarget = .loadPage(page: pageNumber!)
        pkmnTarget = .loadPokemon(nationalID: pkmnNumber!)
    }
    
    override func tearDownWithError() throws {
        pageNumber = nil
        pkmnNumber = nil
        pageTarget = nil
        pkmnTarget = nil
    }
    
    func testTargetInitialization() {
        expect(self.pageTarget).notTo(beNil())
        expect(self.pkmnTarget).notTo(beNil())
    }
    
    func testBaseURLIsAccessibleForPageTarget() {
        if let pageBaseURL = pageTarget?.baseURL {
            expect(pageBaseURL.absoluteString).toNot(beEmpty())
        } else {
            fail("Base URL was not accessible")
        }
    }
    
    func testBaseURLIsAccessibleForPkmnTarget() {
        if let pkmnBaseURL = pkmnTarget?.baseURL {
            expect(pkmnBaseURL.absoluteString).toNot(beEmpty())
        } else {
            fail("Base URL was not accessible")
        }
    }
    
    func testPathIsCorrectlyReturnedForPageTarget() {
        if let pagePath = pageTarget?.path {
            expect(pagePath).notTo(beEmpty())
            expect(pagePath).notTo(contain("\(pageNumber!)"))
        } else {
            fail("Path was not accessible")
        }
    }
    
    func testPathIsCorrectlyReturnedForPkmnTarget() {
        if let pkmnPath = pkmnTarget?.path {
            expect(pkmnPath).notTo(beEmpty())
            expect(pkmnPath).to(contain("\(pkmnNumber!)"))
        } else {
            fail("Path was not accessible")
        }
    }
    
    func testRequestMethodIsGET() {
        if let pageMethod = pageTarget?.method, let pkmnMethod = pkmnTarget?.method {
            expect(pageMethod.rawValue).to(match(Method.get.rawValue))
            expect(pkmnMethod.rawValue).to(match(Method.get.rawValue))
        } else {
            fail("Method is not accessible")
        }
    }
    
    func testHeaders() {
        let pkmnHeaders = pkmnTarget?.headers
        let pageHeaders = pageTarget?.headers
        
        expect(pkmnHeaders).to(haveCount(Environment.defaultHeaders?.count ?? 0))
        expect(pageHeaders).to(haveCount(Environment.defaultHeaders?.count ?? 0))
    }
}
