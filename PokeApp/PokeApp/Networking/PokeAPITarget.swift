//
//  PokemonTarget.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import Moya

enum PokeAPITarget {
    case loadPage(page: Int)
    case loadPokemon(nationalID: Int)
}

extension PokeAPITarget: TargetType {
    var baseURL: URL {
        guard let url = Environment.dexBaseURL else {
            fatalError("Could not retrieve baseURL value for National Dex")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .loadPage(_):
            return "pokemon"
        case .loadPokemon(let nationalID):
            return "pokemon/\(nationalID)"
        }
        
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .loadPage(let page):
            let resultLimit = Environment.dashboardResultLimit
            let resultOffset = page * resultLimit
            let parameters = ["limit": resultLimit, "offset": resultOffset]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .loadPokemon(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return Environment.defaultHeaders
    }
    
    
}
