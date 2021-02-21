//
//  BaseViewController.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import UIKit

class BaseViewController<T: ViewModel, K: Coordinator>: UIViewController {
    private(set) weak var viewModel: T?
    private(set) weak var coordinator: K?
    
    init(viewModel: T, coordinator: K) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
