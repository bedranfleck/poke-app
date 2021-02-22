//
//  ActivityIndicatorView.swift
//  PokeApp
//
//  Created by André Felipe Fleck Bedran on 22/02/21.
//

import SnapKit
import UIKit

protocol LoadTaskIndicatorView: UIViewController {
    var activityIndicator: ActivityIndicatorViewController { get }
}

extension LoadTaskIndicatorView {
    func showIndicatorView() {
        addChild(activityIndicator)
        activityIndicator.view.frame = view.frame
        view.addSubview(activityIndicator.view)
        activityIndicator.didMove(toParent: self)
    }
    
    func removeIndicatorView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.activityIndicator.willMove(toParent: nil)
            self?.activityIndicator.view.removeFromSuperview()
            self?.activityIndicator.removeFromParent()
        }
    }
}

class ActivityIndicatorViewController: UIViewController, ViewCodeConfiguration {
    func setupViewHierarchy() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.addSubview(spinner)
    }
    
    func setupConstraints() {
        spinner.snp.makeConstraints { (make) in
            make.center.equalTo(view.snp.center)
        }
    }
    
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func loadView() {
        setupViews()
        spinner.startAnimating()
    }
    
}
