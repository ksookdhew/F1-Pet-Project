//
//  RaceResultHeader.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/09.
//

import UIKit

class RaceResultHeader: UITableViewHeaderFooterView {
    static let identifier = "RaceResultHeader"
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    static func nib() -> UINib {
        return UINib(nibName: "RaceResultHeader", bundle: nil)
    }
}
