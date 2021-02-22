//
//  ViewCodeConfiguration.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import Foundation

/// Defines a standard way to configure views with view code.
protocol ViewCodeConfiguration {
    func setupViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeConfiguration {
    //Optional implementation
    func configureViews() {}
    
    func setupViews() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
