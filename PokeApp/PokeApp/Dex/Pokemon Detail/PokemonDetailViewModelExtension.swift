//
//  PokemonDetailViewModelExtension.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 22/02/21.
//

import Foundation


protocol PokemonNameProvider: class {
    func pokemonName() -> String?
}

protocol PokemonSpritesProvider: class {
    func normalSpriteURL() -> URL?
    func shinySpriteURL() -> URL?
}

protocol PokemonTypesProvider: class {
    func pokemonPrimaryType() -> String?
    func pokemonSecondaryType() ->String?
}

protocol PokemonAbilitiesProvider: class {
    func firstAbilityName() -> String?
    func secondAbilityName() -> String?
}

protocol PokemonHeightWeightProvider: class {
    func pokemonHeight() -> String?
    func pokemonWeight() -> String?
}

protocol PokemonStatsProvider: class {
    func pokemonHPStat() -> String?
    func pokemonAtkStat() -> String?
    func pokemonDefStat() -> String?
    func pokemonSpAtkStat() -> String?
    func pokemonSpDefStat() -> String?
    func pokemonSpeedStat() -> String?
}

extension PokemonDetailViewModel: PokemonNameProvider {
    func pokemonName() -> String? {
        return pokemon?.name?.capitalized
    }
}

extension PokemonDetailViewModel: PokemonSpritesProvider {
    func normalSpriteURL() -> URL? {
        if let defaultSprite = pokemon?.sprites?.frontDefault {
            return URL(string: defaultSprite)
        } else {
            return nil
        }
    }
    
    func shinySpriteURL() -> URL? {
        if let shinySprite = pokemon?.sprites?.frontShiny {
            return URL(string: shinySprite)
        } else {
            return nil
        }
    }
}

extension PokemonDetailViewModel: PokemonTypesProvider {
    func pokemonPrimaryType() -> String? {
        return pokemon?.types?.first?.name.capitalized
    }
    
    func pokemonSecondaryType() -> String? {
        let first = pokemon?.types?.first?.name
        let last = pokemon?.types?.last?.name
        guard first != last else {
            return nil
        }
        return last?.capitalized
    }
}

extension PokemonDetailViewModel: PokemonAbilitiesProvider {
    func firstAbilityName() -> String? {
        return pokemon?.abilities?.first?.name.capitalized
    }
    
    func secondAbilityName() -> String? {
        guard let abilities = pokemon?.abilities,  abilities.count >= 2 else {
            return nil
        }
        return abilities[1].name.capitalized
    }
}

extension PokemonDetailViewModel: PokemonHeightWeightProvider {
    func pokemonHeight() -> String? {
        if let heightInDecimeters = pokemon?.height {
            let heightInMeters = Double(heightInDecimeters)/10
            return "H: \(heightInMeters) m"
        } else {
            return nil
        }
    }
    
    func pokemonWeight() -> String? {
        if let weightInHectograms = pokemon?.weight {
            let weightInKilograms = Double(weightInHectograms)/10
            return "W: \(weightInKilograms) kg"
        } else {
            return nil
        }
    }
}

extension PokemonDetailViewModel: PokemonStatsProvider {
    func pokemonHPStat() -> String? {
        guard let stats = pokemon?.stats, let value = stats.first(where: {$0.name == "hp"})?.baseStat else {
            return nil
        }
        
        return "Hp: \(value)"
    }
    
    func pokemonAtkStat() -> String? {
        guard let stats = pokemon?.stats, let value = stats.first(where: {$0.name == "attack"})?.baseStat else {
            return nil
        }
        return "Atk: \(value)"
    }
    
    func pokemonDefStat() -> String? {
        guard let stats = pokemon?.stats, let value = stats.first(where: {$0.name == "defense"})?.baseStat else {
            return nil
        }
        return "Def: \(value)"
    }
    
    func pokemonSpAtkStat() -> String? {
        guard let stats = pokemon?.stats, let value = stats.first(where: {$0.name == "special-attack"})?.baseStat else {
            return nil
        }
        return "SpAtk: \(value)"
    }
    
    func pokemonSpDefStat() -> String? {
        guard let stats = pokemon?.stats, let value = stats.first(where: {$0.name == "special-defense"})?.baseStat else {
            return nil
        }
        return "SpDef: \(value)"
    }
    
    func pokemonSpeedStat() -> String? {
        guard let stats = pokemon?.stats, let value = stats.first(where: {$0.name == "speed"})?.baseStat else {
            return nil
        }
        return "Spd: \(value)"
    }
}

