//
//  DexPage.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import Foundation

struct DexPage: Codable {
    let count: Int?
    let next, previous: String?
    let results: [PokemonBasicInfo]?
    
    func hasNextPage() -> Bool {
        return next != nil
    }
}

struct PokemonBasicInfo: Codable {
    let name: String?
    let url: String?
    
    func nationalDexNumber() -> Int? {
        var components = url?.components(separatedBy: "/")
        components?.popLast()
        if let string = components?.last {
            let number = Int(string)
            return number
        }
        return nil
    }
}
