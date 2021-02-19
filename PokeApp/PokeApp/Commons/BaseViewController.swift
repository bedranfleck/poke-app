//
//  BaseViewController.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import UIKit

class BaseViewController<T>: UIViewController {
    private(set) var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
