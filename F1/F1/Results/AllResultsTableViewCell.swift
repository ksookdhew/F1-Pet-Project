//
//  AllResultsTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class AllResultsTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak private var raceCountry: UILabel!
    @IBOutlet weak private var raceName: UILabel!
    @IBOutlet weak private var round: UILabel!
    @IBOutlet weak private var day: UILabel!
    @IBOutlet weak private var month: UILabel!
    @IBOutlet weak private var firstDriver: UILabel!
    @IBOutlet weak private var secondDriver: UILabel!
    @IBOutlet weak private var thirdDriver: UILabel!

    // MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }

    func setUpCell() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        backgroundColor = UIColor.clear
        month.layer.cornerRadius = 8
        month.layer.masksToBounds = true
        firstDriver.layer.cornerRadius = 8
        firstDriver.layer.masksToBounds = true
        secondDriver.layer.cornerRadius = 8
        secondDriver.layer.masksToBounds = true
        thirdDriver.layer.cornerRadius = 8
        thirdDriver.layer.masksToBounds = true
    }

    func populateWith(race: Race, raceDate: DateComponents) {
        raceCountry.text = race.circuit.location.country
        raceName.text = "\(race.raceName) 2024"
        round.text="Round \(race.round)"
        day.text = "\(raceDate.day ?? 0)"
        month.text = "\(Constants.monthAbbreviations[(raceDate.month ?? 1)-1])"
        firstDriver.text = "\(race.results[0].driver.code)"
        secondDriver.text = "\(race.results[1].driver.code)"
        thirdDriver.text = "\(race.results[2].driver.code)"
    }

    static func nib() -> UINib {
        return UINib(nibName: Identifiers.allResultsTableViewCell, bundle: nil)
    }
}
