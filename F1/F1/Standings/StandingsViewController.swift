//
//  ResultsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class StandingsViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var segControl: UISegmentedControl!
    var selectedSegmentIndex = 1

    private lazy var driverViewModel = DriverStandingsViewModel(repository: DriverStandingsRepository(), delegate: self)
    private lazy var constructorViewModel = ConstructorStandingsViewModel(repository: ConstructorStandingsRepository(), delegate: self)
    private lazy var standingsViewModel = StandingsViewModel(driverViewModel: driverViewModel, constructorViewModel: constructorViewModel, navigationDelegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        driverViewModel.fetchDriverStandings()
        constructorViewModel.fetchConstructorStandings()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DriverStTableViewCell.nib(),
                           forCellReuseIdentifier: DriverStTableViewCell.identifier)

    }

    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.selectedSegmentIndex = 1
            tableView.register(DriverStTableViewCell.nib(),
                               forCellReuseIdentifier: DriverStTableViewCell.identifier)
        default:
            self.selectedSegmentIndex = 2
            tableView.register(ConstructorStTableViewCell.nib(),
                               forCellReuseIdentifier: ConstructorStTableViewCell.identifier)
        }
        reloadView()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)

    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDriverSegue" {
            if let destinationVC = segue.destination as? DriverViewController {
                if let driver: DriverStanding = sender as? DriverStanding {
                    destinationVC.driver = driver
                }
            }
        } else if segue.identifier == "showConstructorSegue" {
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
        return selectedSegmentIndex == 1 ? driverViewModel.driversCount : constructorViewModel.constructorCount
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedSegmentIndex {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DriverStTableViewCell.identifier)
                    as? DriverStTableViewCell
            else { return UITableViewCell() }
            guard let result = driverViewModel.driver(atIndex: indexPath.section) else { return UITableViewCell() }
            cell.populateWith(driverSt: result)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstructorStTableViewCell.identifier)
                    as? ConstructorStTableViewCell
            else { return UITableViewCell() }
            guard let result = constructorViewModel.constructor(atIndex: indexPath.section)
            else { return UITableViewCell() }
            guard let drivers = driverViewModel.getConstructorDrivers(constructorID: result.constructor.constructorID)
            else {
                return UITableViewCell()
            }
            cell.populateWith(constructorSt: result, driversList: drivers)
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

protocol StandingsNavigationDelegate: AnyObject {
    func navigateToDriver(_ driver: DriverStanding)
    func navigateToConstructor(_ constructor: ConstructorStanding)
}

extension  StandingsViewController: ViewModelDelegate {

    func reloadView() {
        tableView.reloadData()
        driverViewModel.setConstructors()
    }

    func show(error: String) {
    }

}

extension StandingsViewController: StandingsNavigationDelegate {
    func navigateToDriver(_ driver: DriverStanding) {
        performSegue(withIdentifier: "showDriverSegue", sender: driver)
    }

    func navigateToConstructor(_ constructor: ConstructorStanding) {
        performSegue(withIdentifier: "showConstructorSegue", sender: constructor)
    }
}
