//
//  AllResultsTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class DriverStTableViewCell: UITableViewCell {

    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var constructor: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var points: UILabel!

    static let identifier = "DriverStTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
    }

    func populateWith(driverSt: DriverStanding) {
        position.text = driverSt.position
        name.text = driverSt.driver.givenName
        surname.text = driverSt.driver.familyName
        constructor.text = driverSt.constructors[0].name
        points.text = "\(driverSt.points) PTS"
    }

    static func nib() -> UINib {
        return UINib(nibName: "DriverStTableViewCell", bundle: nil)
    }
}
