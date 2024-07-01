//
//  ConstructorResultHeader.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/09.
//

import UIKit

class ConstructorResultHeader: UITableViewHeaderFooterView {

    // MARK: Functions
    static func nib() -> UINib {
        UINib(nibName: Identifiers.constructorResultsIdentifier, bundle: nil)
    }
}
