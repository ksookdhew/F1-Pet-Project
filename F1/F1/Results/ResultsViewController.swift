//
//  ResultsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class ResultsViewController: LoadingIndicatorViewController {

    private lazy var viewModel = ResultsViewModel(repository: ResultsRepository(), delegate: self)

    // MARK: IBOutlets
    @IBOutlet weak private var allResultsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchResults()
    }

    private func setupTableView() {
        allResultsTableView.delegate = self
        allResultsTableView.dataSource = self
        allResultsTableView.register(AllResultsTableViewCell.nib(),
                                     forCellReuseIdentifier: Identifiers.allResultsTableViewCell)
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
    }

    func show(error: String) {
        showAlert(alertTitle: "Error", alertMessage: "Oops, an error occurred")
    }
}
