//
//  AllResultsTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class AllResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var raceCountry: UILabel!
    @IBOutlet weak var raceName: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var driver1: UILabel!
    @IBOutlet weak var driver2: UILabel!
    @IBOutlet weak var driver3: UILabel!

    let monthAbbreviations = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sap", "Oct", "Nov", "Dec"]
    static let identifier = "AllResultsTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
        self.month.layer.cornerRadius = 8
        self.month.layer.masksToBounds = true
        self.driver1.layer.cornerRadius = 8
        self.driver1.layer.masksToBounds = true
        self.driver2.layer.cornerRadius = 8
        self.driver2.layer.masksToBounds = true
        self.driver3.layer.cornerRadius = 8
        self.driver3.layer.masksToBounds = true

    }

    func populateWith(race: Race, raceDate: DateComponents) {
        raceCountry.text = race.circuit.location.country
        raceName.text = "\(race.raceName) 2024"
        round.text="Round \(race.round)"
        day.text = "\(raceDate.day ?? 0)"
        month.text = "\(monthAbbreviations[(raceDate.month ?? 1)-1])"
        driver1.text = "\(race.results[0].driver.code)"
        driver2.text = "\(race.results[1].driver.code)"
        driver3.text = "\(race.results[2].driver.code)"
    }

    static func nib() -> UINib {
        return UINib(nibName: "AllResultsTableViewCell", bundle: nil)
    }
}
