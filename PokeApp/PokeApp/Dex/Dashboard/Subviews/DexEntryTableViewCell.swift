//
//  DexEntryTableViewCell.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import UIKit
import SnapKit

class DexEntryTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 64.0
    static let baseOffset: CGFloat = 10.0
    static let reuseIdentifier = "DexEntryCell"
    
    private lazy var pkmnImageView: UIImageView = UIImageView(frame: .zero)
    private lazy var stackView: UIStackView = UIStackView(frame: .zero)
    private lazy var pkmnNameLabel: UILabel = UILabel(frame: .zero)
    private lazy var pkmnNumberLabel: UILabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DexEntryTableViewCell: ViewCodeConfiguration {
    func setupViewHierarchy() {
        self.contentView.addSubview(pkmnImageView)
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(pkmnNameLabel)
        stackView.addArrangedSubview(pkmnNumberLabel)
    }
    
    func setupConstraints() {
        self.contentView.clipsToBounds = true
        pkmnImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(DexEntryTableViewCell.baseOffset)
            make.top.equalTo(self.contentView).offset(DexEntryTableViewCell.baseOffset)
            make.bottom.equalTo(self.contentView).offset(-DexEntryTableViewCell.baseOffset)

            //aspect ratio 1:1. Could also have just set to 1 instead of 1/1, but this makes intent clearer.
            make.width.equalTo(pkmnImageView.snp.height).multipliedBy(1/1)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(pkmnImageView.snp.right).offset(DexEntryTableViewCell.baseOffset)
            make.top.equalTo(self.contentView).offset(DexEntryTableViewCell.baseOffset)
            make.bottom.equalTo(self.contentView).offset(-DexEntryTableViewCell.baseOffset)
            make.right.equalTo(self.contentView).offset(-DexEntryTableViewCell.baseOffset)
        }
    }
    
    func configureViews() {
        pkmnImageView.contentMode = .scaleAspectFit
        
        pkmnNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        pkmnNumberLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        
        pkmnNumberLabel.textAlignment = .right
        
    }
    
}
