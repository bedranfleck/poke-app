//
//  PokemonTypesCell.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 21/02/21.
//

import UIKit

class PokemonTypesCell: UITableViewCell {
    static let cellHeight: CGFloat = 84.0
    static let baseOffset: CGFloat = 10.0
    static let chipCornerRadius: CGFloat = 4.0
    static let chipHeight: CGFloat = 35.0
    static let reuseIdentifier = "TypesCell"
    
    private lazy var identifierLabel = UILabel(frame: .zero)
    private lazy var primaryTypeLabel = UILabel(frame: .zero)
    private lazy var secondaryTypeLabel = UILabel(frame: .zero)
    private lazy var stackView = UIStackView(frame: .zero)
    
    weak var viewModel: PokemonTypesProvider? {
        didSet {
            updateInfo()
        }
    }
    
    private func updateInfo() {
        if let primary = viewModel?.pokemonPrimaryType() {
            primaryTypeLabel.text = primary
        }
        guard let secondary = viewModel?.pokemonSecondaryType() else {
            secondaryTypeLabel.isHidden = true
            return
        }
        secondaryTypeLabel.text = secondary
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

}

extension PokemonTypesCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(identifierLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(primaryTypeLabel)
        stackView.addArrangedSubview(secondaryTypeLabel)
    }
    
    func setupConstraints() {
        identifierLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(PokemonTypesCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonTypesCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonTypesCell.baseOffset)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(identifierLabel.snp.bottom).offset(PokemonTypesCell.baseOffset)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-PokemonTypesCell.baseOffset)
        }
        
        primaryTypeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(PokemonTypesCell.chipHeight)
            make.width.equalTo(PokemonTypesCell.chipHeight*5)
        }
        
        secondaryTypeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(PokemonTypesCell.chipHeight)
            make.width.equalTo(PokemonTypesCell.chipHeight*5)
        }
    }
    
    func configureViews() {
        contentView.backgroundColor = .white
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = PokemonTypesCell.baseOffset
        
        identifierLabel.text = "Types"
        identifierLabel.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        primaryTypeLabel.backgroundColor = .blue
        primaryTypeLabel.textColor = .white
        primaryTypeLabel.layer.cornerRadius = PokemonTypesCell.chipCornerRadius
        primaryTypeLabel.clipsToBounds = true
        primaryTypeLabel.textAlignment = .center
        primaryTypeLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
        secondaryTypeLabel.backgroundColor = .red
        secondaryTypeLabel.textColor = .white
        secondaryTypeLabel.layer.cornerRadius = PokemonTypesCell.chipCornerRadius
        secondaryTypeLabel.clipsToBounds = true
        secondaryTypeLabel.textAlignment = .center
        secondaryTypeLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
    }
}
