//
//  RacingResultViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//
import UIKit

class RacingResultViewController: UIViewController {

    var round = ""
    var race: Race?
    @IBOutlet weak var raceName: UILabel!
    @IBOutlet weak var racingResultTableView: UITableView!
    private lazy var viewModel = ResultsViewModel(repository: ResultsRepository(), delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.setRaceResult(raceRes: race!)
        raceName.text = race?.circuit.location.country
    }

    private func setupTableView() {
        racingResultTableView.delegate = self
        racingResultTableView.dataSource = self
        racingResultTableView.register(RaceResultTableViewCell.nib(), forCellReuseIdentifier: RaceResultTableViewCell.identifier)
    }
}
// MARK: - TableView Delegate

 extension RacingResultViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.raceResultsCount
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 42.0
      }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = racingResultTableView.dequeueReusableCell(withIdentifier: RaceResultTableViewCell.identifier)
                as? RaceResultTableViewCell
        else { return UITableViewCell() }
        guard let result = viewModel.raceResult(atIndex: indexPath.item) else { return UITableViewCell() }
        cell.populateWith(result: result)
        return cell
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
