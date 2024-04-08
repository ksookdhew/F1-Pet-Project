//
//  RacingResultViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//
import UIKit

class RacingResultViewController: UIViewController {

    var round = "2"
    @IBOutlet weak var racingResultTableView: UITableView!
    private lazy var viewModel = ResultsViewModel(repository: ResultsRepository(), delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchRoundResults(round: round)
    }

    private func setupTableView() {
        racingResultTableView.delegate = self
        racingResultTableView.dataSource = self
        racingResultTableView.register(AllResultsTableViewCell.nib(), forCellReuseIdentifier: AllResultsTableViewCell.identifier)
    }
                             
}
// MARK: - TableView Delegate

 extension RacingResultViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.raceResultsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = racingResultTableView.dequeueReusableCell(withIdentifier: AllResultsTableViewCell.identifier)
                as? AllResultsTableViewCell
        else { return UITableViewCell() }
        guard let result = viewModel.raceResult(atIndex: indexPath.item) else { return UITableViewCell() }
        cell.populateRaceWith(race: result)
        return cell
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: "Results", bundle: nil)

         let resultsVC = storyboard.instantiateViewController(identifier: "raceResultVC")

         resultsVC.navigationItem.title = "Here"

         navigationController?.pushViewController(resultsVC, animated: true)
     }
 }


extension  RacingResultViewController: ViewModelDelegate {

    func reloadView() {
        racingResultTableView.reloadData()
    }

    func show(error: String) {
        // displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
