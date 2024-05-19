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
    @IBOutlet weak private var driverImg: UIImageView!
    @IBOutlet weak private var driverName: UILabel!
    @IBOutlet weak private var driverNationality: UILabel!
    @IBOutlet weak private var driverConstructor: UILabel!
    @IBOutlet weak private var driverSurname: UILabel!
    @IBOutlet weak private var currentWins: UILabel!
    @IBOutlet weak private var currentPoints: UILabel!
    @IBOutlet weak private var currentPosition: UILabel!

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
        tableView.register(DriverResultHeader.nib(),
                           forHeaderFooterViewReuseIdentifier: Identifiers.driverResultsIdentifier)
    }

    private func setupView() {
        viewModel.setDriver(driver: driver)
        driverImg.image = UIImage(named: viewModel.driverImageName)
        driverName.text = viewModel.driverGivenName
        driverSurname.text = viewModel.driverFamilyName
        driverConstructor.text = viewModel.driverConstructorInfo
        driverNationality.text = viewModel.driverNationality
        currentPosition.text = viewModel.currentPosition
        currentPoints.text = viewModel.currentPoints
        currentWins.text = viewModel.currentWins
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension DriverViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.resultsCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        42.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: Identifiers.driverResultsIdentifier) as? DriverResultHeader else {
            return UITableViewHeaderFooterView()
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
}

extension  DriverViewController: ViewModelDelegate {

    func reloadView() {
        tableView.reloadData()
        hideLoadingIndicator()
    }

    func show(error: String) {
        showAlert(alertTitle: "Error", alertMessage: "Oops, an error occurred")
    }
}
