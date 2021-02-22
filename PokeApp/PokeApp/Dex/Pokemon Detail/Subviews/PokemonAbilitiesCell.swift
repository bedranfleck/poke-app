//
//  PokemonAbilitiesCell.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 21/02/21.
//

import UIKit

class PokemonAbilitiesCell: UITableViewCell {
    static let cellHeight: CGFloat = 84.0
    static let baseOffset: CGFloat = 10.0
    static let chipCornerRadius: CGFloat = 4.0
    static let chipHeight: CGFloat = 35.0
    static let reuseIdentifier = "AbilitiesCell"
    
    private lazy var identifierLabel = UILabel(frame: .zero)
    private lazy var firstAbilityLabel = UILabel(frame: .zero)
    private lazy var secondAbilityLabel = UILabel(frame: .zero)
    private lazy var stackView = UIStackView(frame: .zero)
    
    weak var viewModel: PokemonAbilitiesProvider? {
        didSet {
            updateInfo()
        }
    }
    
    private func updateInfo() {
        if let first = viewModel?.firstAbilityName() {
            firstAbilityLabel.text = first
        }
        guard let second = viewModel?.secondAbilityName() else {
            secondAbilityLabel.isHidden = true
            return
        }
        secondAbilityLabel.text = second
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

}

extension PokemonAbilitiesCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(identifierLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(firstAbilityLabel)
        stackView.addArrangedSubview(secondAbilityLabel)
    }
    
    func setupConstraints() {
        identifierLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(PokemonAbilitiesCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonAbilitiesCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonAbilitiesCell.baseOffset)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(identifierLabel.snp.bottom).offset(PokemonAbilitiesCell.baseOffset)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-PokemonAbilitiesCell.baseOffset)
        }
        
        firstAbilityLabel.snp.makeConstraints { (make) in
            make.height.equalTo(PokemonAbilitiesCell.chipHeight)
            make.width.equalTo(PokemonAbilitiesCell.chipHeight*5)
        }
        
        secondAbilityLabel.snp.makeConstraints { (make) in
            make.height.equalTo(PokemonAbilitiesCell.chipHeight)
            make.width.equalTo(PokemonAbilitiesCell.chipHeight*5)
        }
    }
    
    func configureViews() {
        contentView.backgroundColor = .white
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = PokemonAbilitiesCell.baseOffset
        
        identifierLabel.text = "Abilities"
        identifierLabel.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        firstAbilityLabel.backgroundColor = .purple
        firstAbilityLabel.textColor = .white
        firstAbilityLabel.layer.cornerRadius = PokemonAbilitiesCell.chipCornerRadius
        firstAbilityLabel.clipsToBounds = true
        firstAbilityLabel.textAlignment = .center
        firstAbilityLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
        secondAbilityLabel.backgroundColor = .gray
        secondAbilityLabel.textColor = .white
        secondAbilityLabel.layer.cornerRadius = PokemonAbilitiesCell.chipCornerRadius
        secondAbilityLabel.clipsToBounds = true
        secondAbilityLabel.textAlignment = .center
        secondAbilityLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
    }
}
