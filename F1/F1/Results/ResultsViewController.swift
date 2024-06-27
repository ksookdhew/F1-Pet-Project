//
//  ResultsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class ResultsViewController: LoadingIndicatorViewController {

    // MARK: Variables
    private lazy var viewModel = ResultsViewModel(repository: ResultsRepository(coreDataManager: CoreDataManager()), delegate: self)
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ResultsViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red

        return refreshControl
    }()

    // MARK: IBOutlets
    @IBOutlet weak private var allResultsTableView: UITableView!

    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
        self.allResultsTableView.addSubview(self.refreshControl)
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
        refreshControl.endRefreshing()
    }

    private func setupTableView() {
        allResultsTableView.delegate = self
        allResultsTableView.dataSource = self
        allResultsTableView.register(AllResultsTableViewCell.nib(),
                                     forCellReuseIdentifier: Identifiers.allResultsTableViewCell)
    }

    private func fetchData() {
        if NetworkMonitor.shared.isConnected {
            viewModel.fetchResults()
        } else {
            showAlert(alertTitle: "App is Offline", alertMessage: "The info you see may be outdated")
            viewModel.fetchResultsOffline()
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.showRaceResultsSegue {
            if let destinationVC = segue.destination as? RacingResultViewController {
                if let race: Race = sender as? Race {
                    destinationVC.race = race
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.allResultsCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        4
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        104.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = allResultsTableView
            .dequeueReusableCell(withIdentifier: Identifiers.allResultsTableViewCell) as? AllResultsTableViewCell else {
            return UITableViewCell()
        }
        guard let result = viewModel.allResult(atIndex: indexPath.section) else { return UITableViewCell() }
        cell.populateWith(race: result, raceDate: viewModel.allResultDate(result: result))
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let result = viewModel.allResult(atIndex: indexPath.section) else { return }
        navigate(identifier: Identifiers.showRaceResultsSegue, sender: result)
    }
}

// MARK: - ViewModelDelegate
extension  ResultsViewController: ViewModelDelegate {

    func reloadView() {
        allResultsTableView.reloadData()
        hideLoadingIndicator()
        refreshControl.endRefreshing()
    }

    func show(error: String) {
        showAlert(alertTitle: "Error", alertMessage: "Oops, an error occurred")
    }
}
