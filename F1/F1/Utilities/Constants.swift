//
//  Constants.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/19.
//

import Foundation

struct Identifiers {
    static let DriverResultsIdentifier = "DriverResultHeader"
    static let DriverTableViewCell = "DriverTableViewCell"
    static let ConstructorTableViewCell = "ConstructorTableViewCell"
    static let ConstructorResultsIdentifier = "ConstructorResultHeader"
    static let RaceScheduleIndentifier = "RaceScheduleTableViewCell"
    static let showDriverSegue = "showDriverSegue"
    static let showConstructorSegue = "showConstructorSegue"
}

struct Endpoints {
    static let racing = "https://ergast.com/api/f1/current.JSON"
}
