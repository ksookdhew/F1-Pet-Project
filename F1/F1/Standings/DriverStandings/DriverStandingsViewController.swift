//
//  DriverStandingsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew
//

import UIKit

class DriverStandingsViewController: UIViewController {

    private lazy var viewModel = DriverStandingsViewModel(repository: DriverStandingsRepository(),
                                                      delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchDriverStandings()
    }

}

// MARK: - ViewModel Delegate

extension DriverStandingsViewController: ViewModelDelegate {

    func reloadView() {
        // tableView.reloadData()
    }

    func show(error: String) {
        // displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
