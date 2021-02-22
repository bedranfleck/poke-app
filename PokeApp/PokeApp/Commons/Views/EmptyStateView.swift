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
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyImageAndText() {
        imageView.image = #imageLiteral(resourceName: "sadPikachu")
        label.text = "Pikachu couldn't find the Pokémon you are looking for."
    }
    
}

extension EmptyStateView: ViewCodeConfiguration {
    func setupViewHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.5)
            make.height.equalTo(imageView.snp.width)
        }
    }
    
    func configureViews() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        
        applyImageAndText()
    }
    
}
