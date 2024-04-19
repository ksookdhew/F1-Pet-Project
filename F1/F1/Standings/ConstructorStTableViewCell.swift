//
//  ConstructorStTableViewCell.swift
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
    @IBOutlet weak var constructorImg: UIImageView!

    static let identifier = "ConstructorStTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
    }

    func populateWith(constructorSt: ConstructorStanding, driversList: [Driver?]) {
        position.text = constructorSt.position
        name.text = constructorSt.constructor.name
        points.text = "\(constructorSt.points) PTS"
        constructorImg.image = UIImage(named: "\(constructorSt.constructor.constructorID).png")
        if driversList.count >= 1 {
            if driversList.count >= 2 {
                drivers.text = "\(driversList.first??.code ?? "")/\(driversList[1]?.code ?? "")"
            } else {
                drivers.text = "\(driversList.first??.code ?? "")"
            }} else {
            drivers.text = ""
        }
    }

    static func nib() -> UINib {
        return UINib(nibName: "ConstructorStTableViewCell", bundle: nil)
    }
}
