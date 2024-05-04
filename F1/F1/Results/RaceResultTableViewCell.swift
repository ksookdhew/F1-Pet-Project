//
//  RaceResultTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class RaceResultTableViewCell: UITableViewCell {

    @IBOutlet weak private var position: UILabel!
    @IBOutlet weak private var driver: UILabel!
    @IBOutlet weak private var time: UILabel!
    @IBOutlet weak private var points: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.time.layer.cornerRadius = 8
        self.time.layer.masksToBounds = true
    }

    func populateWith(result: RacingResult, lapTime: String) {
        position.text = result.position
        driver.text = result.driver.code
        time.text = lapTime
        points.text = result.points
    }

    static func nib() -> UINib {
        return UINib(nibName: Identifiers.raceResultTableViewCell, bundle: nil)
    }
}
