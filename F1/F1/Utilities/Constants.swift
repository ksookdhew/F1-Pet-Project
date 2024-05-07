//
//  Constants.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/19.
//

import Foundation

struct Identifiers {
    static let allResultsTableViewCell = "AllResultsTableViewCell"
    static let driverResultsIdentifier = "DriverResultHeader"
    static let driverTableViewCell = "DriverTableViewCell"
    static let driverStandingTableViewCell = "DriverStandingTableViewCell"
    static let constructorTableViewCell = "ConstructorTableViewCell"
    static let constructorResultsIdentifier = "ConstructorResultHeader"
    static let constructorStandingTableViewCell = "ConstructorStandingTableViewCell"
    static let raceScheduleIndentifier = "RaceScheduleTableViewCell"
    static let racingIdentifier = "RacingCollectionViewCell"
    static let raceResultTableViewCell = "RaceResultTableViewCell"
    static let raceResultHeader = "RaceResultHeader"
    static let showDriverSegue = "ShowDriverSegue"
    static let showConstructorSegue = "ShowConstructorSegue"
    static let showRaceSegue = "ShowRaceInfoSegue"
    static let showRaceResultsSegue = "ShowRaceResultsSegue"
}

struct Endpoints {
    static let racing = "https://ergast.com/api/f1/current.JSON"
}

struct Constants {
    static let monthAbbreviations = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

}
