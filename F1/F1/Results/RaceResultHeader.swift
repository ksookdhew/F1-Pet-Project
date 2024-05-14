//
//  RaceResultHeader.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/09.
//

import UIKit

class RaceResultHeader: UITableViewHeaderFooterView {

    static func nib() -> UINib {
        return UINib(nibName: Identifiers.raceResultHeader, bundle: nil)
    }
}
