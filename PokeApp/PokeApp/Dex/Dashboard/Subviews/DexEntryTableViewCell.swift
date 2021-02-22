//
//  DexEntryTableViewCell.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import UIKit
import SnapKit
import Kingfisher

class DexEntryTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 84.0
    static let baseOffset: CGFloat = 10.0
    static let reuseIdentifier = "DexEntryCell"
    
    private lazy var pkmnImageView: UIImageView = UIImageView(frame: .zero)
    private lazy var stackView: UIStackView = UIStackView(frame: .zero)
    private lazy var pkmnNameLabel: UILabel = UILabel(frame: .zero)
    private lazy var pkmnNumberLabel: UILabel = UILabel(frame: .zero)
    
    weak var viewModel: DexEntryViewModel? {
        didSet {
            updateDexEntryInfo()
        }
    }
    
    var entryNumber: Int?
    
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
    
    override func prepareForReuse() {
        pkmnNameLabel.text = nil
        pkmnNumberLabel.text = nil
        pkmnImageView.kf.cancelDownloadTask()
        pkmnImageView.image = nil
        viewModel = nil
    }
    
    private func updateDexEntryInfo() {
        guard let nationalID = entryNumber, viewModel != nil else {
            return
        }
        pkmnNameLabel.text = viewModel?.pokemonName(with: nationalID)
        pkmnNumberLabel.text = viewModel?.formattedEntryNumberText(nationalID)
        if let url = viewModel?.artworkURLForEntry(nationalID) {
            pkmnImageView.kf.setImage(with: url)
        }
        self.layoutSubviews()
        
    }

}

//MARK: - View Code
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
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        pkmnImageView.contentMode = .scaleAspectFit
        pkmnImageView.kf.indicatorType = .activity
        
        pkmnNameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        pkmnNameLabel.textColor = .black
        pkmnNumberLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        pkmnNumberLabel.textColor = .black
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        
        pkmnNumberLabel.textAlignment = .right
        
    }
    
}
