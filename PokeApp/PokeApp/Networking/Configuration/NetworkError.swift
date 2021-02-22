//
//  NetworkError.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import Foundation

enum NetworkError: Int {
    case decodingError = -1
    case notConnected = -2
    case noPagesAvailable = -3
    case unknownError = -4
    
    func raw() -> Error {
        switch self {
        case .decodingError:
            return NSError(domain: "br.com.andrebedran.PokeApp",
                           code: -1,
                           userInfo: ["description": "Unable to decode Codable type from JSON dictionary."])
        case .notConnected:
            return NSError(domain: "br.com.andrebedran.PokeApp",
                           code: -2,
                           userInfo: ["description": "Device could not complete the request due to network unavailability."])
        case .noPagesAvailable:
            return NSError(domain: "br.com.andrebedran.PokeApp",
                           code: -3,
                           userInfo: ["description": "Could not fetch next resource page."])
        
        case .unknownError:
            return NSError(domain: "br.com.andrebedran.PokeApp",
                           code: -3,
                           userInfo: ["description": "An unknown error occurred."])
        }
    }
    
    static func from(_ error: Error?) -> NetworkError {
        if let error = error as NSError?, let networkError = NetworkError(rawValue: error.code) {
            return networkError
        } else {
            return .unknownError
        }
    }
}
