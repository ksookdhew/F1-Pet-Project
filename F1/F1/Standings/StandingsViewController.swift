//
//  ResultsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class StandingsViewController: UIViewController {
    @IBOutlet weak var driverTableView: UITableView!
    private lazy var driverViewModel = DriverStandingsViewModel(repository: DriverStandingsRepository(), delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        driverViewModel.fetchDriverStandings()
    }

    private func setupTableView() {
        driverTableView.delegate = self
        driverTableView.dataSource = self
        driverTableView.register(DriverStTableViewCell.nib(),
        forCellReuseIdentifier: DriverStTableViewCell.identifier)
    }

    // MARK: - Navigation
}

// MARK: - TableView Delegate

 extension StandingsViewController: UITableViewDelegate, UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
         return driverViewModel.driversCount
     }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 148.0
     }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//         let headerView = UIView()
//         headerView.backgroundColor = UIColor.clear
//         return headerView
//     }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = driverTableView.dequeueReusableCell(withIdentifier: DriverStTableViewCell.identifier)
                as? DriverStTableViewCell
        else { return UITableViewCell() }
        guard let result = driverViewModel.driver(atIndex: indexPath.section) else { return UITableViewCell() }
        cell.populateWith(driverSt: result)
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        return cell
    }

//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         guard let result = viewModel.driver(atIndex: indexPath.section) else { return }
//         performSegue(withIdentifier: "show??Segue", sender: result)
//     }
 }

extension  StandingsViewController: ViewModelDelegate {

    func reloadView() {
        driverTableView.reloadData()
    }

    func show(error: String) {
        // displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
