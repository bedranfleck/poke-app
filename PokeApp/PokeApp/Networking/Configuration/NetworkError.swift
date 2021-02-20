//
//  NetworkError.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import Foundation

enum NetworkError {
    case decodingError
    case notConnected
    
    func raw() -> Error {
        switch self {
        case .decodingError:
            return NSError(domain: "br.com.andrebedran.PokeApp", code: -1, userInfo: ["description": "Unable to decode Codable type from JSON dictionary."])
        case .notConnected:
            return NSError(domain: "br.com.andrebedran.PokeApp", code: -2, userInfo: ["description": "Device could not complete the request due to network unavailability."])
        }
    }
}
