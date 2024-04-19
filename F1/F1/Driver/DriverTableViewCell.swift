//
//  DriverTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class DriverTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var round: UILabel!
    @IBOutlet weak private var race: UILabel!
    @IBOutlet weak private var time: UILabel!
    @IBOutlet weak private var points: UILabel!
    @IBOutlet weak private var position: UILabel!
    
    static let identifier = "DriverTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        time.layer.cornerRadius = 8
        time.layer.masksToBounds = true
    }
    
    func populateWith(result: Race, lapTime: String) {
        round.text = result.round
        race.text = result.circuit.location.locality
        time.text = lapTime
        points.text = result.results[0].points
        position.text = result.results[0].position
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
