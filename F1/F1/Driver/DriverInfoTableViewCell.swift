//
//  DriverInfoTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/26.
//

import UIKit

class DriverInfoTableViewCell: UITableViewCell {

        @IBOutlet weak private var driverImage: UIImageView!
        @IBOutlet weak private var driverName: UILabel!
        @IBOutlet weak private var driverNationality: UILabel!
        @IBOutlet weak private var driverConstructor: UILabel!
        @IBOutlet weak private var driverSurname: UILabel!
        @IBOutlet weak private var currentWins: UILabel!
        @IBOutlet weak private var currentPoints: UILabel!
        @IBOutlet weak private var currentPosition: UILabel!
        @IBOutlet weak private var tableHeading: UILabel!
        @IBOutlet weak private var winsHeading: UILabel!
        @IBOutlet weak private var pointsHeading: UILabel!
        @IBOutlet weak private var posHeading: UILabel!
        @IBOutlet weak private var statsHeading: UILabel!

    func populateWith(driver: DriverStanding) {
        driverImage.image = UIImage(named: driver.driver.code)
        driverName.text = driver.driver.givenName
        driverSurname.text = driver.driver.familyName
        driverConstructor.text = "\(driver.driver.permanentNumber ) | \(driver.constructors.first?.name ?? "")"
        driverNationality.text = driver.driver.nationality
        currentPosition.text = driver.position
        currentPoints.text = driver.points
        currentWins.text = driver.wins
    }

    static func nib() -> UINib {
        return UINib(nibName: Identifiers.driverInfoTableViewCell, bundle: nil)
    }

}
