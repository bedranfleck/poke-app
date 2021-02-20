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
}

struct PokemonBasicInfo: Codable {
    let name: String?
    let url: String?
}
