//
//  RaceResultTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class RaceResultTableViewCell: UITableViewCell {

    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var driver: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var points: UILabel!

    static let identifier = "RaceResultTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.time.layer.cornerRadius = 8
        self.time.layer.masksToBounds = true
    }

    func populateWith(result: RacingResult) {
        position.text = result.position
        driver.text = result.driver.code

        if let resTime = result.time?.time {
            time.text = resTime
        } else {
            var stat = result.status
            if !stat.contains("Lap") {
                stat = "DNF"
            }
            time.text = stat
        }

        points.text = result.points
    }

    static func nib() -> UINib {
        return UINib(nibName: "RaceResultTableViewCell", bundle: nil)
    }
}
