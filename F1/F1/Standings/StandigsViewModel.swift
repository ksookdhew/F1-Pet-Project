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
    private let driverViewModel: DriverStandingsViewModel
    private let constructorViewModel: ConstructorStandingsViewModel

    init(driverViewModel: DriverStandingsViewModel, constructorViewModel: ConstructorStandingsViewModel, navigationDelegate: StandingsNavigationDelegate?) {
        self.driverViewModel = driverViewModel
        self.constructorViewModel = constructorViewModel
        self.navigationDelegate = navigationDelegate
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
}
