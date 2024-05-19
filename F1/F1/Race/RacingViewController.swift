//
//  RacingViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/28.
//

import UIKit

class RacingViewController: LoadingIndicatorViewController {

    private lazy var viewModel = RaceViewModel(repository: RaceRepository(), delegate: self)

    // MARK: IBOutlets
    @IBOutlet weak private var collectionView: UICollectionView!

    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRace()
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RacingCollectionViewCell.nib(), forCellWithReuseIdentifier: Identifiers.racingIdentifier)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.showRaceSegue {
            if let destinationVC = segue.destination as? RaceViewController,
               let race: RaceInfo = sender as? RaceInfo {
                destinationVC.raceInfo = race
            }
        }
    }
}

// MARK: - UICollectionViewDelegate and UICollectionViewDataSource
extension RacingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.racesCount
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 86, height: 98)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: Identifiers.racingIdentifier, for: indexPath as IndexPath) as? RacingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let race = viewModel.race(atIndex: indexPath.item)
        cell.populateWith(raceName: race.circuit.location.locality, track: viewModel.imageName(circuitCode: race.circuit.circuitID), raceDate: viewModel.sessionDate(date: race.date))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = viewModel.race(atIndex: indexPath.item)
        navigate(identifier: Identifiers.showRaceSegue, sender: result)
    }
}

// MARK: - ViewModelDelegate
extension  RacingViewController: ViewModelDelegate {
    func reloadView() {
        collectionView.reloadData()
        hideLoadingIndicator()
    }

    func show(error: String) {
        showAlert(alertTitle: "Error", alertMessage: "Oops, an error occurred")
    }
}
