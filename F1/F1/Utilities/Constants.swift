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
    static let driverInfoTableViewCell = "DriverInfoTableViewCell"
    static let driverStandingTableViewCell = "DriverStandingTableViewCell"
    static let constructorTableViewCell = "ConstructorTableViewCell"
    static let constructorInfoTableViewCell = "ConstructorInfoTableViewCell"
    static let constructorResultsIdentifier = "ConstructorResultHeader"
    static let constructorStandingTableViewCell = "ConstructorStandingTableViewCell"
    static let raceScheduleIndentifier = "RaceScheduleTableViewCell"
    static let racingIdentifier = "RacingCollectionViewCell"
    static let raceResultTableViewCell = "RaceResultTableViewCell"
    static let raceResultHeader = "RaceResultHeader"
    static let login = "Login"
    static let showDriverSegue = "ShowDriverSegue"
    static let showConstructorSegue = "ShowConstructorSegue"
    static let showRaceSegue = "ShowRaceInfoSegue"
    static let showRaceResultsSegue = "ShowRaceResultsSegue"
    static let showTabSegue = "ShowTabSegue"
    static let logOutSegue = "LogOutSegue"
}

struct Endpoints {
    static let racing = "https://ergast.com/api/f1/current.JSON"
    static let constructor = "https://ergast.com/api/f1/current/constructors/"
    static let driver = "https://ergast.com/api/f1/current/drivers/"
    static let driverStanding = "https://ergast.com/api/f1/current/driverStandings.JSON"
    static let constructorStanding = "https:ergast.com/api/f1/current/constructorStandings.JSON"
    static let racingResults = "https://ergast.com/api/f1/current/results.JSON?limit=200"
    static let roundResult = "https://ergast.com/api/f1/current/"
}

struct Constants {
    static let monthAbbreviations = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

}

struct Flags {
    static var offline = false
}
