//
//  AllResultsTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class ConstructorStTableViewCell: UITableViewCell {

    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var drivers: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var points: UILabel!

    static let identifier = "ConstructorStTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
    }

    func populateWith(constructorSt: ConstructorStanding) {
        position.text = constructorSt.position
        name.text = constructorSt.constructor.name
        points.text = "\(constructorSt.points) PTS"
    }

    static func nib() -> UINib {
        return UINib(nibName: "ConstructorStTableViewCell", bundle: nil)
    }
}
