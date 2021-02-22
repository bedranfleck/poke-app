//
//  DashboardViewController.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import UIKit
import SnapKit


class DashboardViewController: BaseViewController<DashboardViewModel, DashboardCoordinator> {

    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel?.delegate = self
        setupViews()
        viewModel?.fetchNewDexPage()
    }
    
}

// MARK: - Network Layer Events
extension DashboardViewController: PokeAPIObserver {
    func pokeAPIDidUpdateState(_ state: PokeAPI.State) {
        switch state {
        case .idle(let error):
            if let error = error {
                let message = (error.raw() as NSError).userInfo["description"] as? String
                let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                self.present(errorAlert, animated: true, completion: nil)
                
            }
        default:
            
            print("Hit Load")
        }
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.entryCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DexEntryTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? DexEntryTableViewCell {
            cell.entryNumber = indexPath.row + 1
            cell.viewModel = viewModel
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        if indexPath.row == viewModel.entryCount()-1 && viewModel.entryCount() < DashboardViewModel.maxNumberOfEntries {
            viewModel.fetchNewDexPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dexNum = viewModel?.dexNumberForEntry(indexPath.row+1) {
            coordinator?.didSelectPokemon(with: dexNum)
        }
    }
}

extension DashboardViewController: DashboarViewModelDelegate {
    func updateEntries() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension DashboardViewController: ViewCodeConfiguration {
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
        self.title = "Poor Man's Dex"
        self.view.backgroundColor = .white
        
        tableView.rowHeight = DexEntryTableViewCell.cellHeight
        tableView.register(DexEntryTableViewCell.self, forCellReuseIdentifier: DexEntryTableViewCell.reuseIdentifier)
        setupLargeText()
        
    }
    
    private func setupLargeText() {
        if let navBar = self.navigationController?.navigationBar {
            navBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
            navBar.backgroundColor = .white
            navBar.largeTitleTextAttributes =
                [.foregroundColor: UIColor.blue]
        }
    }
    
    
}
