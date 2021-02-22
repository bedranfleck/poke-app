//
//  PokemonDetailViewController.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import UIKit

class PokemonDetailViewController: BaseViewController<PokemonDetailViewModel, PokemonDetailCoordinator>, LoadTaskIndicatorView {
    var activityIndicator = ActivityIndicatorViewController()
    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel?.delegate = self
        
        viewModel?.fetchPokemon()
        
        setupViews()
    }
    
    private func applyEmptyState() {
        guard viewModel?.emptyStateType() != nil else { return }
        tableView.separatorStyle = .none
        let emptyStateView = EmptyStateView(frame: tableView.frame)
        self.tableView.backgroundView = emptyStateView
    }
    
    private func removeEmptyState() {
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
    }

}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func viewModelDidUpdateState(newState: PokemonDetailViewModel.State) {
        switch newState {
        case .loadError:
            removeIndicatorView()
            applyEmptyState()
            tableView.reloadData()
        case .loadSuccess:
            removeIndicatorView()
            removeEmptyState()
            tableView.reloadData()
        case .loading:
            showIndicatorView()
            tableView.separatorStyle = .none
        }
    }
}

extension PokemonDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = viewModel?.cellType(for: indexPath.row) else {
            return UITableViewCell()
        }
        switch cellType {
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonNameCell.reuseIdentifier) as! PokemonNameCell
            cell.viewModel = viewModel
            return cell
        case .sprites:
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonSpritesCell.reuseIdentifier) as! PokemonSpritesCell
            cell.viewModel = viewModel
            return cell
        case .types:
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTypesCell.reuseIdentifier) as! PokemonTypesCell
            cell.viewModel = viewModel
            return cell
        case .abilities:
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonAbilitiesCell.reuseIdentifier) as! PokemonAbilitiesCell
            cell.viewModel = viewModel
            return cell
        case .weightAndHeight:
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonHeightWeightCell.reuseIdentifier) as! PokemonHeightWeightCell
            cell.viewModel = viewModel
            return cell
        case .stats:
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonStatsCell.reuseIdentifier) as! PokemonStatsCell
            cell.viewModel = viewModel
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellType = viewModel?.cellType(for: indexPath.row) else {
            return .leastNonzeroMagnitude
        }
        switch cellType {
        case .name:
            return PokemonNameCell.cellHeight
        case .sprites:
            return PokemonSpritesCell.cellHeight
        case .types:
            return PokemonTypesCell.cellHeight
        case .abilities:
            return PokemonAbilitiesCell.cellHeight
        case .weightAndHeight:
            return PokemonHeightWeightCell.cellHeight
        case .stats:
            return PokemonStatsCell.cellHeight
        }
    }
    
}

extension PokemonDetailViewController: ViewCodeConfiguration {
    func setupViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func configureViews() {
        self.title = "Details"
        self.view.backgroundColor = .white
        
        navigationItem.largeTitleDisplayMode = .never
        
        tableView.register(PokemonNameCell.self, forCellReuseIdentifier: PokemonNameCell.reuseIdentifier)
        tableView.register(PokemonSpritesCell.self, forCellReuseIdentifier: PokemonSpritesCell.reuseIdentifier)
        tableView.register(PokemonTypesCell.self, forCellReuseIdentifier: PokemonTypesCell.reuseIdentifier)
        tableView.register(PokemonAbilitiesCell.self, forCellReuseIdentifier: PokemonAbilitiesCell.reuseIdentifier)
        tableView.register(PokemonHeightWeightCell.self, forCellReuseIdentifier: PokemonHeightWeightCell.reuseIdentifier)
        tableView.register(PokemonStatsCell.self, forCellReuseIdentifier: PokemonStatsCell.reuseIdentifier)
        
        tableView.bounces = false
        
    }
    
}
