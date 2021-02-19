//
//  Environment.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import Foundation

class Environment {
    static let dexBaseURL = URL(string: "https://" + Configuration.value(for: .dexBaseURL))
    static let artworkBaseURL = URL(string: "https://" + Configuration.value(for: .artworkBaseURL))
}
