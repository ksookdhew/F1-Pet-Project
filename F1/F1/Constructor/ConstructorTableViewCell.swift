//
//  ConstructorTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class ConstructorTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var round: UILabel!
    @IBOutlet weak private var race: UILabel!
    @IBOutlet weak private var firstDriver: UILabel!
    @IBOutlet weak private var firstPoints: UILabel!
    @IBOutlet weak private var firstPosition: UILabel!
    @IBOutlet weak private var secondDriver: UILabel!
    @IBOutlet weak private var secondPoints: UILabel!
    @IBOutlet weak private var secondPosition: UILabel!
    
    static let identifier = Identifiers.ConstructorTableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        firstDriver.layer.cornerRadius = 8
        firstDriver.layer.masksToBounds = true
        secondDriver.layer.cornerRadius = 8
        secondDriver.layer.masksToBounds = true
    }

    func populateWith(result: Race) {
        round.text = result.round
        race.text = result.circuit.location.locality
        firstDriver.text = result.results.first?.driver.code
        firstPoints.text = result.results.first?.points
        firstPosition.text = result.results.first?.position

        if result.results.count > 1 {
            secondDriver.text = result.results.last?.driver.code
            secondPoints.text = result.results.last?.points
            secondPosition.text = result.results.last?.position
        } else {
            secondDriver.isHidden = true
            secondPosition.isHidden = true
            secondPoints.isHidden = true
        }
    }

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
