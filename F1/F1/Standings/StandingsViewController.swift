//
//  ResultsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class StandingsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var segControl: UISegmentedControl!

    // MARK: Variables
    var selectedSegmentIndex = 1
    private lazy var driverViewModel = DriverStandingsViewModel(repository: DriverStandingsRepository(), delegate: self)
    private lazy var constructorViewModel = ConstructorStandingsViewModel(repository: ConstructorStandingsRepository(), delegate: self)
    private lazy var standingsViewModel = StandingsViewModel(driverViewModel: driverViewModel, constructorViewModel: constructorViewModel, navigationDelegate: self)

    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        driverViewModel.fetchDriverStandings()
        constructorViewModel.fetchConstructorStandings()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DriverStandingTableViewCell.nib(),
                           forCellReuseIdentifier: Identifiers.driverStandingTableViewCell)

    }

    // MARK: IBAction
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.selectedSegmentIndex = 1
            tableView.register(DriverStandingTableViewCell.nib(),
                               forCellReuseIdentifier: Identifiers.driverStandingTableViewCell)
        default:
            self.selectedSegmentIndex = 2
            tableView.register(ConstructorStandingTableViewCell.nib(),
                               forCellReuseIdentifier: Identifiers.constructorStandingTableViewCell)
        }
        reloadView()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)

    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.showDriverSegue {
            if let destinationVC = segue.destination as? DriverViewController {
                if let driver: DriverStanding = sender as? DriverStanding {
                    destinationVC.driver = driver
                }
            }
        } else if segue.identifier == Identifiers.showConstructorSegue {
            if let destinationVC = segue.destination as? ConstructorViewController {
                if let constructor: ConstructorStanding = sender as? ConstructorStanding {
                    destinationVC.constructor = constructor
                }
            }
        }
    }
}

// MARK: - TableView Delegate
extension StandingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        selectedSegmentIndex == 1 ? driverViewModel.driversCount : constructorViewModel.constructorCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        148.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedSegmentIndex {
        case 1:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: Identifiers.driverStandingTableViewCell) as? DriverStandingTableViewCell else {
                return UITableViewCell()
            }
            guard let result = driverViewModel.driver(atIndex: indexPath.section) else { return UITableViewCell() }
            cell.populateWith(driverStanding: result)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            return cell

        default:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: Identifiers.constructorStandingTableViewCell) as? ConstructorStandingTableViewCell else {
                return UITableViewCell()
            }
            guard let result = constructorViewModel.constructor(atIndex: indexPath.section)
            else { return UITableViewCell() }
            guard let drivers = driverViewModel.getConstructorDrivers(constructorID: result.constructor.constructorID) else {
                return UITableViewCell()
            }
            let driverText = constructorViewModel.drivers(driversList: drivers)
            cell.populateWith(constructorStanding: result, driverText: driverText)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        standingsViewModel.navigateTo(indexPath: indexPath, selectedSegmentIndex: selectedSegmentIndex)
    }
}

extension  StandingsViewController: ViewModelDelegate {
    func reloadView() {
        tableView.reloadData()
        driverViewModel.setConstructors()
    }

    func show(error: String) {
        showAlert(alertTitle: "Error", alertMessage: "Oops, an error occurred")
    }
}

// MARK: Navigation Delegate
protocol StandingsNavigationDelegate: AnyObject {
    func navigateToDriver(_ driver: DriverStanding)
    func navigateToConstructor(_ constructor: ConstructorStanding)
}

extension StandingsViewController: StandingsNavigationDelegate {

    func navigateToDriver(_ driver: DriverStanding) {
        navigate(identifier: Identifiers.showDriverSegue, sender: driver)
    }

    func navigateToConstructor(_ constructor: ConstructorStanding) {
        navigate(identifier: Identifiers.showConstructorSegue, sender: constructor)
    }
}
