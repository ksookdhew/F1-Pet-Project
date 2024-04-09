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
        racingResultTableView.register(UINib(nibName: "RaceResultHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "RaceResultHeader")
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
     
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         guard let headerView = racingResultTableView.dequeueReusableHeaderFooterView(withIdentifier: "RaceResultHeader") as? RaceResultHeader
         else { return UITableViewHeaderFooterView() }
     return headerView
     }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     return 45
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
