//
//  Configuration.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import Foundation

class Configuration: CustomStringConvertible {
    enum Keys: String, CaseIterable {
        case dexBaseURL = "PkmnDexBaseURL"
        case artworkBaseURL = "ArtworkBaseURL"
    }
    
    static func value(for key: Configuration.Keys) -> String {
        guard let dictionary = Bundle.main.object(forInfoDictionaryKey: "ConfigurationVariables") as? [String: String], let value = dictionary[key.rawValue] else {
            fatalError("Tried to access a non-available key-value pair from configuration.")
        }
        
        return value
    }
    
    var description: String {
        var desc = "["
        for key in Configuration.Keys.allCases {
            desc += "\(key.rawValue): \(Configuration.value(for: key))"
            if key != Configuration.Keys.allCases.last {
                desc += ",\n"
            }
        }
        desc += "]"
        
        return desc
    }
}
