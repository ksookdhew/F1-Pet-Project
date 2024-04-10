//
//  ResultsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var allResultsTableView: UITableView!
    private lazy var viewModel = ResultsViewModel(repository: ResultsRepository(), delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchResults()
    }

    private func setupTableView() {
        allResultsTableView.delegate = self
        allResultsTableView.dataSource = self
        allResultsTableView.register(AllResultsTableViewCell.nib(),
        forCellReuseIdentifier: AllResultsTableViewCell.identifier)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showRaceResultsSegue" {
                if let destinationVC = segue.destination as? RacingResultViewController {
                    if let race: Race = sender as? Race {
                        destinationVC.race = race
                    }
                }
            }
        }
}

// MARK: - TableView Delegate

 extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
         return viewModel.allResultsCount
     }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 104.0
     }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UIView()
         headerView.backgroundColor = UIColor.clear
         return headerView
     }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = allResultsTableView.dequeueReusableCell(withIdentifier: AllResultsTableViewCell.identifier)
                as? AllResultsTableViewCell
        else { return UITableViewCell() }
        guard let result = viewModel.allResult(atIndex: indexPath.section) else { return UITableViewCell() }
        cell.populateWith(race: result, raceDate: viewModel.allResultDate(atIndex: indexPath.section))
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bgColorView
        return cell
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let result = viewModel.allResult(atIndex: indexPath.section) else { return }
         performSegue(withIdentifier: "showRaceResultsSegue", sender: result)
     }
 }

extension  ResultsViewController: ViewModelDelegate {

    func reloadView() {
        allResultsTableView.reloadData()
    }

    func show(error: String) {
        // displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
