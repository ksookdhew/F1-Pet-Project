//
//  AllResultsTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class AllResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var raceName: UILabel!
    static let identifier = "AllResultsTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populateWith(race: Race) {
        raceName.text = race.raceName
    }
    
    func populateRaceWith(race: RacingResult) {
        raceName.text = race.driver.familyName
    }

    static func nib() -> UINib {
        return UINib(nibName: "AllResultsTableViewCell", bundle: nil)
    }
}
