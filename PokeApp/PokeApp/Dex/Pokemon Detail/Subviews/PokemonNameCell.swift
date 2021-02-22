//
//  PokemonNameCell.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 21/02/21.
//

import UIKit
import SnapKit

class PokemonNameCell: UITableViewCell {
    static let cellHeight: CGFloat = 44.0
    static let baseOffset: CGFloat = 10.0
    static let reuseIdentifier = "NameCell"
    
    private lazy var nameLabel = UILabel(frame: .zero)
    
    weak var viewModel: PokemonNameProvider? {
        didSet {
            updateInfo()
        }
    }
    
    private func updateInfo() {
        nameLabel.text = viewModel?.pokemonName()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
}

extension PokemonNameCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.left.equalTo(contentView).offset(PokemonNameCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonNameCell.baseOffset)
        }
    }
    
    func configureViews() {
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.text = "Pikachu"
        nameLabel.textAlignment = .center
        contentView.backgroundColor = .lightGray
    }
}
