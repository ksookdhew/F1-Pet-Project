//
//  RacingResultViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//
import UIKit

class RacingResultViewController: UIViewController {

    private lazy var viewModel = ResultsViewModel(repository: ResultsRepository(coreDataManager: CoreDataManager()), delegate: self)

    // MARK: IBOutlets
    @IBOutlet weak private var raceName: UILabel!
    @IBOutlet weak private var racingResultTableView: UITableView!

    // MARK: Variables
    var race: Race?

    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.setRaceResult(raceResult: race)
        raceName.text = race?.circuit.location.country
    }

    private func setupTableView() {
        racingResultTableView.delegate = self
        racingResultTableView.dataSource = self
        racingResultTableView.register(RaceResultTableViewCell.nib(),
                                       forCellReuseIdentifier: Identifiers.raceResultTableViewCell)
        racingResultTableView.register(UINib(nibName: Identifiers.raceResultHeader, bundle: nil),
                                       forHeaderFooterViewReuseIdentifier: Identifiers.raceResultHeader)
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension RacingResultViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.raceResultsCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        42.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = racingResultTableView
            .dequeueReusableCell(withIdentifier: Identifiers.raceResultTableViewCell)
                as? RaceResultTableViewCell else {
            return UITableViewCell()
        }
        guard let result = viewModel.raceResult(atIndex: indexPath.item) else { return UITableViewCell() }
        let laptime = viewModel.laptime(index: indexPath.item)
        cell.populateWith(result: result, lapTime: laptime)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = racingResultTableView
            .dequeueReusableHeaderFooterView(withIdentifier: Identifiers.raceResultHeader) as? RaceResultHeader else {
            return UITableViewHeaderFooterView()
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
}

// MARK: - ViewModelDelegate
extension  RacingResultViewController: ViewModelDelegate {

    func reloadView() {
        racingResultTableView.reloadData()
    }

    func show(error: String) {
        showAlert(alertTitle: "Error", alertMessage: "Oops, an error occurred")
    }
}
