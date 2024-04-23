//
//  DriverResultHeader.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/09.
//

import UIKit

class DriverResultHeader: UITableViewHeaderFooterView {
    static let identifier = Identifiers.driverResultsIdentifier

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
