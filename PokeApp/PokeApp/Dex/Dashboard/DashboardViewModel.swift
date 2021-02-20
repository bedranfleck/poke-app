//
//  DashboardViewModel.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import Foundation

class DashboardViewModel: ViewModel {
    private weak var pokeAPI: PokeAPI?
    
    init(pokeAPI: PokeAPI?) {
        self.pokeAPI = pokeAPI
    }
}
