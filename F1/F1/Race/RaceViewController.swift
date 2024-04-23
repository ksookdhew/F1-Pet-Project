//
//  RaceViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class RaceViewController: UIViewController {
    private lazy var viewModel = RaceViewModel(repository: RaceRepository(), delegate: self)

    // MARK: IBOutlets
    @IBOutlet weak private var raceTitle: UILabel!
    @IBOutlet weak private var raceName: UILabel!
    @IBOutlet weak private var raceLocation: UILabel!
    @IBOutlet weak private var tableView: UITableView!

    // MARK: Variables
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
        tableView.register(RaceScheduleTableViewCell.nib(), forCellReuseIdentifier: Identifiers.raceScheduleIndentifier)
        tableView.sectionHeaderTopPadding = 0.0
    }

    private func setupView() {
        raceInfo = viewModel.race
        raceTitle.text = viewModel.raceTitle
        raceName.text = viewModel.raceName
        raceLocation.text = viewModel.raceLocation
        viewModel.processRaceSessions()
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
        viewModel.scheduleCount
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
       guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.raceScheduleIndentifier)
               as? RaceScheduleTableViewCell
       else { return UITableViewCell() }
       let result = viewModel.raceSession(atIndex: indexPath.section)
       let sessionDate = viewModel.sessionDate(date: result.date)
       let sessionTime = viewModel.sessionTime(time: result.time)
       cell.populateWith(sessionName: result.type.rawValue, sessionDate: sessionDate, sessionTime: sessionTime)
       return cell
   }
}
