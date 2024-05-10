//
//  ViewModelDelegate.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/10.
//

import Foundation

// MARK: ViewModelDelegate protocol
protocol ViewModelDelegate: AnyObject {
    func reloadView()
    func show(error: String)
}
