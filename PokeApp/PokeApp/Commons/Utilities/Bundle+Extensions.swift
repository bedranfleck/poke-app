//
//  Bundle+Extensions.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import Foundation

extension Bundle {
    static func loadJSONFromBundle(bundle: Bundle = Bundle.main, resourceName: String) -> Data {
        guard let url = bundle.url(forResource: resourceName, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        
        return data
    }
}
