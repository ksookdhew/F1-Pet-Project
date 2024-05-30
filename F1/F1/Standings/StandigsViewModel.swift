//
//  StandigsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/19.
//

import Foundation
class StandingsViewModel {

    // MARK: Variables
    private weak var navigationDelegate: StandingsNavigationDelegate?
    private weak var delegate: ViewModelDelegate?
    private var driverStanding: [DriverStanding]?
    private var constructorStanding: [ConstructorStanding]?
    let driverViewModel: DriverStandingsViewModel
    let constructorViewModel: ConstructorStandingsViewModel

    init(navigationDelegate: StandingsNavigationDelegate?, delegate: ViewModelDelegate) {
        self.driverViewModel = DriverStandingsViewModel(repository: DriverStandingsRepository())
        self.constructorViewModel = ConstructorStandingsViewModel(repository: ConstructorStandingsRepository())
        self.navigationDelegate = navigationDelegate
        self.delegate = delegate
    }
    // MARK: Computed Variables
    var isLoaded: Bool {
        driverViewModel.isLoaded && constructorViewModel.isLoaded
    }

    // MARK: Functions
    func navigateTo(indexPath: IndexPath, selectedSegmentIndex: Int) {
        switch selectedSegmentIndex {
        case 1:
            if let driver = driverViewModel.driver(atIndex: indexPath.section) {
                navigationDelegate?.navigateToDriver(driver)
            }
        default:
            if let constructor = constructorViewModel.constructor(atIndex: indexPath.section) {
                navigationDelegate?.navigateToConstructor(constructor)
            }
        }
    }

    func fetchStandings() {
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        driverViewModel.fetchDriverStandings { [weak self] driverStandings in
            if driverStandings != nil {
                self?.driverStanding = driverStandings
            } else {
                self?.delegate?.show(error: "Error")
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        constructorViewModel.fetchConstructorStandings { [weak self] constructorStandings in
            if constructorStandings != nil {
                self?.constructorStanding = constructorStandings
            } else {
                self?.delegate?.show(error: "Error")
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            if self?.driverStanding != nil && self?.constructorStanding != nil {
                self?.delegate?.reloadView()
            } else {
                self?.delegate?.show(error: "Error")
            }
        }
    }

}
