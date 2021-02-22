//
//  PokeAPIService.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import Moya

final class PokeAPIService: BaseService<PokeAPITarget> {
    
    typealias DexPageCompletion = (_ dexPage: DexPage?, _ error: Error?) -> Void
    typealias PokemonDetailCompletion = (_ pokemon: Pokemon?, _ error: Error?) -> Void
    
    func fetchDexPage(number: Int, completion: @escaping DexPageCompletion) {
        self.provider.request(.loadPage(page: number)) { (result) in
            switch result {
            case .success(let response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    
                    guard !response.data.isEmpty else {
                        completion(nil, NetworkError.decodingError.raw())
                        return
                    }
                    
                    let dexPage = try JSONDecoder().decode(DexPage.self, from: response.data)
                    completion(dexPage, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func fetchPokemon(by nationalID: Int, completion: @escaping PokemonDetailCompletion) {
        self.provider.request(.loadPokemon(nationalID: nationalID)) { (result) in
            switch result {
            case .success(let response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    
                    guard !response.data.isEmpty else {
                        completion(nil, NetworkError.decodingError.raw())
                        return
                    }
                    
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: response.data)
                    completion(pokemon, nil)
                        
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
