//
//  RaceResultTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class RaceResultTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak private var position: UILabel!
    @IBOutlet weak private var driver: UILabel!
    @IBOutlet weak private var time: UILabel!
    @IBOutlet weak private var points: UILabel!

    // MARK: Functions
    func populateWith(result: RaceResult, lapTime: String) {
        position.text = result.position
        driver.text = result.driver.code
        time.text = lapTime
        points.text = result.points
    }

    static func nib() -> UINib {
        UINib(nibName: Identifiers.raceResultTableViewCell, bundle: nil)
    }
}
