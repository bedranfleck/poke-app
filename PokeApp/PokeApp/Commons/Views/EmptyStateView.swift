//
//  DetailLoadingView.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 21/02/21.
//

import UIKit
import SnapKit

class EmptyStateView: UIView {
    private lazy var imageView = UIImageView(frame: .zero)
    private lazy var stackView = UIStackView(frame: .zero)
    private lazy var label = UILabel(frame: .zero)
    
    var emptyStateType: PokemonDetailViewModel.EmptyStateViewType
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EmptyStateView: ViewCodeConfiguration {
    func setupViewHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        <#code#>
    }
    
}
