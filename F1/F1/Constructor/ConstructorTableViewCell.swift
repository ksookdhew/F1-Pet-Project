//
//  RaceResultTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class ConstructorTableViewCell: UITableViewCell {

    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var race: UILabel!
    @IBOutlet weak var driver: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var pos: UILabel!

    static let identifier = "ConstructorTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.driver.layer.cornerRadius = 8
        self.driver.layer.masksToBounds = true
    }

    func populateWith(result: Race) {
        round.text = result.round
        race.text = result.circuit.location.locality
        driver.text = result.results[0].driver.code
        points.text = result.results[0].points
        pos.text = result.results[0].position
    }

    static func nib() -> UINib {
        return UINib(nibName: "ConstructorTableViewCell", bundle: nil)
    }
}
