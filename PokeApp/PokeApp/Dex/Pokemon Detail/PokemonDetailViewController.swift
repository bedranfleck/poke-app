//
//  PokemonDetailViewController.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 20/02/21.
//

import UIKit

class PokemonDetailViewController: BaseViewController<PokemonDetailViewModel, PokemonDetailCoordinator> {

    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        viewModel?.delegate = self
        
        viewModel?.fetchPokemon()
        
        setupViews()
    }

}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func viewModelDidUpdateState() {
        tableView.reloadData()
    }
}

extension PokemonDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
        
        tableView.rowHeight = DexEntryTableViewCell.cellHeight
        tableView.register(DexEntryTableViewCell.self, forCellReuseIdentifier: DexEntryTableViewCell.reuseIdentifier)
        
    }
    
}

