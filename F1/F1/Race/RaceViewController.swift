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
    private var raceInfo: RaceInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRace()
        raceInfo = viewModel.race
        raceTitle.text = raceInfo?.circuit.location.country
        raceName.text = raceInfo?.raceName
        raceLocation.text = "\(raceInfo?.circuit.location.locality ?? "") | \(raceInfo?.circuit.location.country ?? "")"
    }

}

extension  RaceViewController: ViewModelDelegate {
    func reloadView() {
        raceInfo = viewModel.race
        raceTitle.text = raceInfo?.circuit.location.country
        raceName.text = raceInfo?.raceName
        raceLocation.text = "\(raceInfo?.circuit.location.locality ?? "") | \(raceInfo?.circuit.location.country ?? "")"
        viewModel.raceSessionsCalculator()
    }

    func show(error: String) {
    }
}
