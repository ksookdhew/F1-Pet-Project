//
//  RaceResultTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class DriverTableViewCell: UITableViewCell {

    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var race: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var pos: UILabel!

    static let identifier = "DriverTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.time.layer.cornerRadius = 8
        self.time.layer.masksToBounds = true
    }

    func populateWith(result: Race, lapTime: String) {
        round.text = result.round
        race.text = result.circuit.location.locality
        time.text = lapTime
        points.text = result.results[0].points
        pos.text = result.results[0].position
    }

    static func nib() -> UINib {
        return UINib(nibName: "DriverTableViewCell", bundle: nil)
    }
}
