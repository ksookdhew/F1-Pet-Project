//
//  Constants.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/19.
//

import Foundation

struct Identifiers {
    static let driverResultsIdentifier = "DriverResultHeader"
    static let driverTableViewCell = "DriverTableViewCell"
    static let constructorTableViewCell = "ConstructorTableViewCell"
    static let constructorResultsIdentifier = "ConstructorResultHeader"
    static let raceScheduleIndentifier = "RaceScheduleTableViewCell"
    static let showDriverSegue = "ShowDriverSegue"
    static let showConstructorSegue = "ShowConstructorSegue"
}

struct Endpoints {
    static let racing = "https://ergast.com/api/f1/current.JSON"
}
