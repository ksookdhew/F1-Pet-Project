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

    // MARK: Variable
    private let monthAbbreviations = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    // MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        backgroundColor = UIColor.clear
        raceMonth.layer.cornerRadius = 8
        raceMonth.layer.masksToBounds = true
    }

    func populateWith(sessionName: String, sessionDate: DateComponents, sessionTime: String) {
        raceDay.text = "\(sessionDate.day ?? 0)"
        raceMonth.text = "\(monthAbbreviations[(sessionDate.month ?? 1)-1])"
        session.text = sessionName
        time.text = sessionTime
    }

    static func nib() -> UINib {
        return UINib(nibName: Identifiers.RaceScheduleIndentifier, bundle: nil)
    }
}
