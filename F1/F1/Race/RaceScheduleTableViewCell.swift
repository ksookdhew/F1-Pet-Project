//
//  RaceScheduleTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/20.
//

import UIKit

class RaceScheduleTableViewCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet weak private var raceDay: UILabel!
    @IBOutlet weak private var raceMonth: UILabel!
    @IBOutlet weak private var session: UILabel!
    @IBOutlet weak private var time: UILabel!

    // MARK: Functions
    func populateWith(sessionName: String, sessionDate: DateComponents, sessionTime: String) {
        raceDay.text = "\(sessionDate.day ?? 0)"
        raceMonth.text = "\(Constants.monthAbbreviations[(sessionDate.month ?? 1) - 1])"
        session.text = sessionName
        time.text = sessionTime
    }

    static func nib() -> UINib {
        UINib(nibName: Identifiers.raceScheduleIndentifier, bundle: nil)
    }
}
