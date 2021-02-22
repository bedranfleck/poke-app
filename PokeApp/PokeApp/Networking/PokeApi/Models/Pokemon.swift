//
//  Pokemon.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import Foundation

// MARK: - Pokémon
struct Pokemon: Codable {
    let abilities: [Ability]?
    let baseExperience, height, id: Int?
    let isDefault: Bool?
    let name: String?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?

    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case height, id
        case isDefault = "is_default"
        case name, sprites, stats, types, weight
    }
}

// MARK: - Ability
struct Ability: Codable {
    private let ability: Detail?
    let isHidden: Bool?
    let slot: Int?
    var name: String {
        get {
            return ability?.name ?? ""
        }
    }

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - StatClass
struct Detail: Codable {
    let name: String?
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault, backFemale, backShiny, backShinyFemale: String?
    let frontDefault, frontFemale, frontShiny, frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int?
    private let stat: Detail?
    var name: String {
        get {
            return stat?.name ?? ""
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    private let type: Detail?
    var name: String {
        get {
            return type?.name ?? ""
        }
    }
}
