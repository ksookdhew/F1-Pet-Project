//
//  ConstructorStandingsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew
//
import UIKit

class ConstructorStandingsViewController: UIViewController {

    private lazy var viewModel = ConstructorStandingsViewModel(repository:
            ConstructorStandingsRepository(), delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchConstructorStandings()
        // Do any additional setup after loading the view.
    }

}

// MARK: - ViewModel Delegate

extension ConstructorStandingsViewController: ViewModelDelegate {

    func reloadView() {
        // tableView.reloadData()
    }

    func show(error: String) {
        // displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
