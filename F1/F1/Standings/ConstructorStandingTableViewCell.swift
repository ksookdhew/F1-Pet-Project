//
//  ConstructorStTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/08.
//

import UIKit

class ConstructorStandingTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak private var position: UILabel!
    @IBOutlet weak private var drivers: UILabel!
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var points: UILabel!
    @IBOutlet weak private var constructorImage: UIImageView!

    // MARK: Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
    }

    func populateWith(constructorStanding: ConstructorStanding,driverText: String) {
        position.text = constructorStanding.position
        name.text = constructorStanding.constructor.name
        points.text = "\(constructorStanding.points) PTS"
        constructorImage.image = UIImage(named: "\(constructorStanding.constructor.constructorID).png")
        drivers.text = driverText
    }

    static func nib() -> UINib {
        return UINib(nibName: Identifiers.constructorStandingTableViewCell, bundle: nil)
    }
}
