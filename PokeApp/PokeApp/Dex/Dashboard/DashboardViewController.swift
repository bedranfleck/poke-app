//
//  DashboardViewController.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 19/02/21.
//

import UIKit
import SnapKit

class DashboardViewController: BaseViewController<DashboardViewModel> {

    private lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    

}

// MARK: - Network Layer Events
extension DashboardViewController: PokeAPIObserver {
    func pokeAPIDidUpdateState(_ state: PokeAPI.State) {
        //Trigger loading view state
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 600
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DexEntryTableViewCell.reuseIdentifier, for: indexPath)
        return cell
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
        if let navBar = self.navigationController?.navigationBar {
            navBar.prefersLargeTitles = true
            navBar.backgroundColor = .white
            navBar.largeTitleTextAttributes =
                [.foregroundColor: UIColor.blue]
        }
        self.view.backgroundColor = .white
        
        self.title = "National Dex"
        tableView.dataSource = self
        tableView.rowHeight = DexEntryTableViewCell.cellHeight
        tableView.register(DexEntryTableViewCell.self, forCellReuseIdentifier: DexEntryTableViewCell.reuseIdentifier)
    }
    
}
