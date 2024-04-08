//
//  RaceResultTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class RaceResultTableViewCell: UITableViewCell {

    @IBOutlet weak var driver: UILabel!

    static let identifier = "RaceResultTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populateWith(race: RacingResult) {
        driver.text = race.driver.familyName
    }

    static func nib() -> UINib {
        return UINib(nibName: "RaceResultTableViewCell", bundle: nil)
    }
}
