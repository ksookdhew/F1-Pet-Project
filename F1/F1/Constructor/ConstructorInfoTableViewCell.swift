//
//  ConstructorInfoTableViewCell.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/26.
//

import UIKit

class ConstructorInfoTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak private var constructorImage: UIImageView!
    @IBOutlet weak private var constructorName: UILabel!
    @IBOutlet weak private var  constructorNationality: UILabel!
    @IBOutlet weak private var  constructorDriver: UILabel!
    @IBOutlet weak private var  currentWins: UILabel!
    @IBOutlet weak private var  currentPoints: UILabel!
    @IBOutlet weak private var  currentPosition: UILabel!
    
    // MARK: Functions
    func populateWith(constructor: ConstructorStanding, drivers: String) {
        constructorImage.image = UIImage(named: constructor.constructor.constructorID)
        constructorName.text = constructor.constructor.name
        constructorDriver.text = drivers
        constructorNationality.text =  constructor.constructor.nationality
        currentPosition.text = constructor.position
        currentPoints.text = constructor.points
        currentWins.text = constructor.wins
    }
    static func nib() -> UINib {
        return UINib(nibName: Identifiers.constructorInfoTableViewCell, bundle: nil)
    }
}
