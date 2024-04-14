//
//  RaceResultHeader.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/09.
//

import UIKit

class ConstructorResultHeader: UITableViewHeaderFooterView {
    static let identifier = "ConstructorResultHeader"

    static func nib() -> UINib {
        return UINib(nibName: "ConstructorResultHeader", bundle: nil)
    }
}
