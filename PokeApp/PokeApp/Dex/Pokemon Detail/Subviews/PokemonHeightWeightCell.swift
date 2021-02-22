//
//  PokemonHeightWeightCell.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 21/02/21.
//

import UIKit

class PokemonHeightWeightCell: UITableViewCell {
    static let cellHeight: CGFloat = 84.0
    static let baseOffset: CGFloat = 10.0
    static let chipCornerRadius: CGFloat = 4.0
    static let chipHeight: CGFloat = 35.0
    static let reuseIdentifier = "HeightWeightCell"
    
    private lazy var identifierLabel = UILabel(frame: .zero)
    private lazy var heightLabel = UILabel(frame: .zero)
    private lazy var weightLabel = UILabel(frame: .zero)
    private lazy var stackView = UIStackView(frame: .zero)
    
    weak var viewModel: PokemonHeightWeightProvider? {
        didSet {
            updateInfo()
        }
    }
    
    private func updateInfo() {
        heightLabel.text = viewModel?.pokemonHeight()
        weightLabel.text = viewModel?.pokemonWeight()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

}

extension PokemonHeightWeightCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(identifierLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(weightLabel)
    }
    
    func setupConstraints() {
        identifierLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(identifierLabel.snp.bottom).offset(PokemonHeightWeightCell.baseOffset)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset)
        }
        
        heightLabel.snp.makeConstraints { (make) in
            make.height.equalTo(PokemonHeightWeightCell.chipHeight)
            make.width.equalTo(PokemonHeightWeightCell.chipHeight*5)
        }
        
        weightLabel.snp.makeConstraints { (make) in
            make.height.equalTo(PokemonHeightWeightCell.chipHeight)
            make.width.equalTo(PokemonHeightWeightCell.chipHeight*5)
        }
    }
    
    func configureViews() {
        contentView.backgroundColor = .white
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = PokemonHeightWeightCell.baseOffset
        
        identifierLabel.text = "Height and Weight"
        identifierLabel.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        heightLabel.backgroundColor = .blue
        heightLabel.textColor = .white
        heightLabel.layer.cornerRadius = PokemonHeightWeightCell.chipCornerRadius
        heightLabel.clipsToBounds = true
        heightLabel.textAlignment = .center
        heightLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
        weightLabel.backgroundColor = .red
        weightLabel.textColor = .white
        weightLabel.layer.cornerRadius = PokemonHeightWeightCell.chipCornerRadius
        weightLabel.clipsToBounds = true
        weightLabel.textAlignment = .center
        weightLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
    }
}
