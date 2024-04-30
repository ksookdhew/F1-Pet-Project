//
//  RacingCollectionViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/28.
//

import UIKit

class RacingCollectionViewCell: UICollectionViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var raceName: UILabel!
    @IBOutlet weak var raceDate: UILabel!
    @IBOutlet weak var circuitImage: UIImageView!

    // MARK: Functions
    func populateWith(raceName: String, track: String, raceDate: DateComponents) {
        self.raceName.text = raceName
        self.raceDate.text = "\(raceDate.day ?? 0) \(Constants.monthAbbreviations[(raceDate.month ?? 1)-1])"
        circuitImage.image = UIImage(named: track)
    }

    static func nib() -> UINib {
        return UINib(nibName: Identifiers.racingIdentifier, bundle: nil)
    }
}
