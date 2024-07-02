//
//  DriverResultHeader.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/09.
//

import UIKit

class DriverResultHeader: UITableViewHeaderFooterView {

    static func nib() -> UINib {
        UINib(nibName: Identifiers.driverResultsIdentifier, bundle: nil)
    }
}
