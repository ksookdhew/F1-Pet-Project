//
//  RaceViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class RaceViewController: UIViewController {
    private lazy var viewModel = RaceViewModel(repository: RaceRepository(), delegate: self)

    @IBOutlet weak private var raceTitle: UILabel!
    @IBOutlet weak private var raceName: UILabel!
    @IBOutlet weak private var raceLocation: UILabel!
    @IBOutlet weak private var tableView: UITableView!
    private var raceInfo: RaceInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRace()
        setupView()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RaceScheduleTableViewCell.nib(),
        forCellReuseIdentifier: RaceScheduleTableViewCell.identifier)
        tableView.sectionHeaderTopPadding = 0.0
    }

    private func setupView() {
        raceInfo = viewModel.race
        raceTitle.text = raceInfo?.circuit.location.country
        raceName.text = raceInfo?.raceName
        raceLocation.text = "\(raceInfo?.circuit.location.locality ?? "") | \(raceInfo?.circuit.location.country ?? "")"
        viewModel.raceSessionsCalculator()
    }
}

// MARK: - ViewModelDelegate 
extension  RaceViewController: ViewModelDelegate {
    func reloadView() {
        tableView.reloadData()
    }

    func show(error: String) {
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension RaceViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.scheduleCount
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
   }
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 10
   }

   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 69.0
    }
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: RaceScheduleTableViewCell.identifier)
               as? RaceScheduleTableViewCell
       else { return UITableViewCell() }
       let result = viewModel.raceSession(atIndex: indexPath.section)
       let sessionDate = viewModel.sessionDate(date: result.value.date)
       let sessionTime = viewModel.sessionTime(time: result.value.time)
       cell.populateWith(sessionName: result.key, sessionDate: sessionDate, sessionTime: sessionTime)
       let bgColorView = UIView()
       bgColorView.backgroundColor = UIColor.clear
       cell.selectedBackgroundView = bgColorView
       return cell
   }
}
