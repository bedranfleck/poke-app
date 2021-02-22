//
//  DashboardViewModel.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import Foundation

protocol DexEntryViewModel: class {
    func pokemonName(with nationalID: Int) -> String?
    func formattedEntryNumberText(_ nationalID: Int) -> String?
    func artworkURLForEntry(_ nationalID: Int) -> URL?
}

protocol DashboarViewModelDelegate: class {
    func updateEntries()
}

class DashboardViewModel: ViewModel {
    //Current number of entries on PokeApi.co
    static let maxNumberOfEntries = 1118
    
    private weak var pokeAPI: PokeAPI?
    // Stores basic info in dictionary keyed with the national dex number
    private var pokemonEntries: [PokemonBasicInfo] = []
    weak var delegate: DashboarViewModelDelegate?
    
    init(pokeAPI: PokeAPI?) {
        self.pokeAPI = pokeAPI
    }
    
    func fetchNewDexPage() {
        guard entryCount() < DashboardViewModel.maxNumberOfEntries else {
            return
        }
        pokeAPI?.fetchDexPage(completion: { (pokemon) in
            if let pokemonInfo = pokemon {
                _ = pokemonInfo.map {[weak self] in
                    if let unwrappedSelf = self,
                       let number = $0.nationalDexNumber(),
                       !unwrappedSelf.pokemonEntries.contains(where: {$0.nationalDexNumber() == number}) {
                        self?.pokemonEntries.append($0)
                    }
                }
            }
            self.delegate?.updateEntries()
        })
    }
    
    func entryCount() -> Int {
        return pokemonEntries.count
    }
    
    func dexNumberForEntry(_ nationalID: Int) -> Int? {
        return dexEntryForNationalID(nationalID)?.nationalDexNumber()
    }
    
}

extension DashboardViewModel: DexEntryViewModel {
    private func dexEntryForNationalID(_ nationalID: Int) -> PokemonBasicInfo? {
        guard nationalID > 0, nationalID <= pokemonEntries.count else {
            return nil
        }
        return pokemonEntries[nationalID-1]
    }
    
    func pokemonName(with nationalID: Int) -> String? {
        return dexEntryForNationalID(nationalID)?.name?.capitalized
    }
    
    func formattedEntryNumberText(_ nationalID: Int) -> String? {
        return "#\(nationalID)"
    }
    
    func artworkURLForEntry(_ nationalID: Int) -> URL? {
        let baseUrl = Environment.artworkBaseURL
        guard let pokemon = dexEntryForNationalID(nationalID) else { return nil }
        let path = pokemon.nationalDexNumber() ?? 0
        return baseUrl?.appendingPathComponent("\(path).png")
    }
}
