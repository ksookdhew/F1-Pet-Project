//
//  AllResultsTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class DriverStandingTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak private var position: UILabel!
    @IBOutlet weak private var constructor: UILabel!
    @IBOutlet weak private var surname: UILabel!
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var points: UILabel!
    @IBOutlet weak private var driverImage: UIImageView!

    // MARK: Functions
    func populateWith(driverStanding: DriverStanding) {
        position.text = driverStanding.position
        name.text = driverStanding.driver.givenName
        surname.text = driverStanding.driver.familyName
        constructor.text = driverStanding.constructors[0].name
        points.text = "\(driverStanding.points) PTS"
        driverImage.image = UIImage(named: "\(driverStanding.driver.code).png")
    }

    static func nib() -> UINib {
        return UINib(nibName: Identifiers.driverStandingTableViewCell, bundle: nil)
    }
}
