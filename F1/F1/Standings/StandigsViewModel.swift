//
//  StandigsViewModel.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/19.
//

import Foundation
class StandingsViewModel {

    private let driverViewModel: DriverStandingsViewModel
    private let constructorViewModel: ConstructorStandingsViewModel
    private weak var navigationDelegate: StandingsNavigationDelegate?

    init(driverViewModel: DriverStandingsViewModel, constructorViewModel: ConstructorStandingsViewModel, navigationDelegate: StandingsNavigationDelegate?) {
        self.driverViewModel = driverViewModel
        self.constructorViewModel = constructorViewModel
        self.navigationDelegate = navigationDelegate
    }

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
