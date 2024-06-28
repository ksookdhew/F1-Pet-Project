//
//  DriverViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import UIKit

class DriverViewController: LoadingIndicatorViewController {

    // MARK: IBOutlets
    @IBOutlet weak private var tableView: UITableView!

    // MARK: Variables
    var driver: DriverStanding?
    private lazy var viewModel = DriverViewModel(repository: DriverRepository(), delegate: self)

    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchDriver(driverName: driver?.driver.driverID)
        setupView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DriverTableViewCell.nib(),
                           forCellReuseIdentifier: Identifiers.driverTableViewCell)
        tableView.register(DriverInfoTableViewCell.nib(),
                           forCellReuseIdentifier: Identifiers.driverInfoTableViewCell)
        tableView.register(DriverResultHeader.nib(),
                           forHeaderFooterViewReuseIdentifier: Identifiers.driverResultsIdentifier)
    }

    private func setupView() {
        viewModel.setDriver(driver: driver)
        tableView.isHidden = true
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension DriverViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = [1, viewModel.resultsCount]
        return numberOfRows[section]
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heights = [375.0, 42.0]
        return heights[indexPath.section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: Identifiers.driverInfoTableViewCell) as? DriverInfoTableViewCell else {
                return UITableViewCell()
            }
            guard let result = driver else {
                return UITableViewCell()
            }
            cell.populateWith(driver: result)
            return cell

        default:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: Identifiers.driverTableViewCell) as? DriverTableViewCell else {
                return UITableViewCell()
            }
            guard let result = viewModel.result(atIndex: indexPath.item) else {
                return UITableViewCell()
            }
            let laptime = viewModel.laptime(index: indexPath.item)
            cell.populateWith(result: result, lapTime: laptime)
            return cell

        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: Identifiers.driverResultsIdentifier) as? DriverResultHeader else {
            return UITableViewHeaderFooterView()
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeights = [0.0, 45.0]
        return headerHeights[section]
    }
}

extension  DriverViewController: ViewModelDelegate {

    func reloadView() {
        tableView.reloadData()
        hideLoadingIndicator()
        tableView.isHidden = false
    }

    func show(error: String) {
        showAlert(alertTitle: "Error", alertMessage: "Oops, an error occurred")
        hideLoadingIndicator()
    }
}
