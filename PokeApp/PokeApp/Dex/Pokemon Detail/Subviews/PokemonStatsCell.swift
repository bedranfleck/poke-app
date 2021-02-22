//
//  PokemonStatsCell.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 21/02/21.
//

import UIKit

class PokemonStatsCell: UITableViewCell {
    static let cellHeight: CGFloat = 215.0
    static let baseOffset: CGFloat = 10.0
    static let baseLabelHeight: CGFloat = 25.0
    static let reuseIdentifier = "StatsCell"
    
    private lazy var identifierLabel = UILabel(frame: .zero)
    
    private lazy var hpLabel = UILabel(frame: .zero)
    private lazy var atkLabel = UILabel(frame: .zero)
    private lazy var defLabel = UILabel(frame: .zero)
    private lazy var spAtkLabel = UILabel(frame: .zero)
    private lazy var spDefLabel = UILabel(frame: .zero)
    private lazy var speedLabel = UILabel(frame: .zero)
    
    weak var viewModel: PokemonStatsProvider? {
        didSet {
            updateInfo()
        }
    }
    
    private func updateInfo() {
        hpLabel.text = viewModel?.pokemonHPStat()
        atkLabel.text = viewModel?.pokemonAtkStat()
        defLabel.text = viewModel?.pokemonDefStat()
        spAtkLabel.text = viewModel?.pokemonSpAtkStat()
        spDefLabel.text = viewModel?.pokemonSpDefStat()
        speedLabel.text = viewModel?.pokemonSpeedStat()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
}

extension PokemonStatsCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(identifierLabel)
        contentView.addSubview(hpLabel)
        contentView.addSubview(atkLabel)
        contentView.addSubview(defLabel)
        contentView.addSubview(spAtkLabel)
        contentView.addSubview(spDefLabel)
        contentView.addSubview(speedLabel)
    }
    
    func setupConstraints() {
        identifierLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset)
            make.height.equalTo(PokemonStatsCell.baseLabelHeight)
        }
        
        hpLabel.snp.makeConstraints { (make) in
            make.top.equalTo(identifierLabel.snp.bottom).offset(PokemonHeightWeightCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset)
            make.height.equalTo(PokemonStatsCell.baseLabelHeight)
        }
        
        atkLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hpLabel.snp.bottom).offset(PokemonHeightWeightCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset)
            make.height.equalTo(PokemonStatsCell.baseLabelHeight)
        }
        
        defLabel.snp.makeConstraints { (make) in
            make.top.equalTo(atkLabel.snp.bottom).offset(PokemonHeightWeightCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset)
            make.height.equalTo(PokemonStatsCell.baseLabelHeight)
        }
        
        spAtkLabel.snp.makeConstraints { (make) in
            make.top.equalTo(defLabel.snp.bottom).offset(PokemonHeightWeightCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset)
            make.height.equalTo(PokemonStatsCell.baseLabelHeight)
        }
        
        spDefLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spAtkLabel.snp.bottom).offset(PokemonHeightWeightCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset)
            make.height.equalTo(PokemonStatsCell.baseLabelHeight)
        }
        
        speedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spDefLabel.snp.bottom).offset(PokemonHeightWeightCell.baseOffset/2)
            make.left.equalTo(contentView).offset(PokemonHeightWeightCell.baseOffset)
            make.right.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset)
            make.bottom.equalTo(contentView).offset(-PokemonHeightWeightCell.baseOffset/2)
            make.height.equalTo(PokemonStatsCell.baseLabelHeight)
            
        }
    }
    
    func configureViews() {
        contentView.backgroundColor = .white
        
        identifierLabel.text = "Stats"
        identifierLabel.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        hpLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        atkLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        defLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        spAtkLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        spDefLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        speedLabel.font = .systemFont(ofSize: 16.0, weight: .semibold)
        
        hpLabel.textAlignment = .center
        atkLabel.textAlignment = .center
        defLabel.textAlignment = .center
        spAtkLabel.textAlignment = .center
        spDefLabel.textAlignment = .center
        speedLabel.textAlignment = .center
    }
}
