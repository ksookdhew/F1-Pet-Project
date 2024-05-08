//
//  DriverTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class DriverTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak private var round: UILabel!
    @IBOutlet weak private var race: UILabel!
    @IBOutlet weak private var time: UILabel!
    @IBOutlet weak private var points: UILabel!
    @IBOutlet weak private var position: UILabel!

    // MARK: Functions
    func populateWith(result: Race, lapTime: String) {
        round.text = result.round
        race.text = result.circuit.location.locality
        time.text = lapTime
        points.text = result.results.first?.points
        position.text = result.results.first?.position
    }

    static func nib() -> UINib {
        return UINib(nibName: Identifiers.driverTableViewCell, bundle: nil)
    }
}
