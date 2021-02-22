//
//  PokemonSpritesCell.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 21/02/21.
//

import UIKit
import SnapKit
import Kingfisher

class PokemonSpritesCell: UITableViewCell {
    static let cellHeight: CGFloat = 160.0
    static let baseOffset: CGFloat = 10.0
    static let baseLabelHeight: CGFloat = 25.0
    static let reuseIdentifier = "SpritesCell"
    
    private lazy var identifierLabel = UILabel(frame: .zero)
    private lazy var normalImageLabel = UILabel(frame: .zero)
    private lazy var shinyImageLabel = UILabel(frame: .zero)
    private lazy var stackView = UIStackView(frame: .zero)
    private lazy var normalImageStackView = UIStackView(frame: .zero)
    private lazy var shinyImageStackView = UIStackView(frame: .zero)
    private lazy var normalSpriteImageView = UIImageView(frame: .zero)
    private lazy var shinySpriteImageView = UIImageView(frame: .zero)
    
    weak var viewModel: PokemonSpritesProvider? {
        didSet {
            updateInfo()
        }
    }
    
    private func updateInfo() {
        if let normalSpriteURL = viewModel?.normalSpriteURL() {
            normalSpriteImageView.kf.setImage(with: normalSpriteURL)
        }
        guard let shinySpriteURL = viewModel?.shinySpriteURL() else {
            shinyImageStackView.isHidden = true
            return
        }
        shinySpriteImageView.kf.setImage(with: shinySpriteURL)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

}

extension PokemonSpritesCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(identifierLabel)
        contentView.addSubview(stackView)
        
        normalImageStackView.addArrangedSubview(normalSpriteImageView)
        normalImageStackView.addArrangedSubview(normalImageLabel)
        
        shinyImageStackView.addArrangedSubview(shinySpriteImageView)
        shinyImageStackView.addArrangedSubview(shinyImageLabel)
        
        stackView.addArrangedSubview(normalImageStackView)
        stackView.addArrangedSubview(shinyImageStackView)
    }
    
    func setupConstraints() {
        identifierLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(PokemonSpritesCell.baseOffset)
            make.top.equalTo(contentView).offset(PokemonSpritesCell.baseOffset/2)
            make.height.equalTo(PokemonSpritesCell.baseLabelHeight)
            make.right.equalTo(contentView).offset(-PokemonSpritesCell.baseOffset)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(contentView.frame.width * 0.1)
            make.top.equalTo(identifierLabel.snp.bottom).offset(PokemonSpritesCell.baseOffset/2)
            make.right.equalTo(contentView).offset(-(contentView.frame.width * 0.1))
            make.bottom.equalTo(contentView).offset(-PokemonSpritesCell.baseOffset/2)
        }
        
        normalSpriteImageView.snp.makeConstraints { (make) in
            make.height.equalTo(contentView).multipliedBy(0.5)
            make.width.equalTo(normalSpriteImageView.snp.height)
        }
        
        shinySpriteImageView.snp.makeConstraints { (make) in
            make.height.equalTo(contentView).multipliedBy(0.5)
            make.width.equalTo(shinySpriteImageView.snp.height)
        }
        
    }
    
    func configureViews() {
        contentView.backgroundColor = .white
        identifierLabel.font = .systemFont(ofSize: 18.0, weight: .semibold)
        
        identifierLabel.text = "Sprites"
        normalImageLabel.text = "Normal"
        shinyImageLabel.text = "Shiny"
        
        normalImageLabel.textAlignment = .center
        shinyImageLabel.textAlignment = .center
        
        normalSpriteImageView.contentMode = .scaleAspectFit
        shinySpriteImageView.contentMode = .scaleAspectFit
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = contentView.frame.width * 0.1
        
        normalImageStackView.axis = .vertical
        normalImageStackView.alignment = .fill
        normalImageStackView.distribution = .equalSpacing
        
        shinyImageStackView.axis = .vertical
        shinyImageStackView.alignment = .fill
        shinyImageStackView.distribution = .equalSpacing
        
        normalSpriteImageView.kf.indicatorType = .activity
        shinySpriteImageView.kf.indicatorType = .activity
    }
}
