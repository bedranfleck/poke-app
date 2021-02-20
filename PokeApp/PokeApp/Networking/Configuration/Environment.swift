//
//  Environment.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import Foundation

class Environment {
    static let dexBaseURL = URL(string: "https://" + Configuration.value(for: .dexBaseURL))
    static let artworkBaseURL = URL(string: "https://" + Configuration.value(for: .artworkBaseURL))
    static let dashboardResultLimit = 20
    static let defaultHeaders: [String: String]? = ["accept": "*/*"]
    
    class func isRunningUnitTests() -> Bool {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return true
        } else {
            return false
        }
    }
}
