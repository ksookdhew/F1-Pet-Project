//
//  DateFormatter.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/09.
//

import Foundation

extension DateFormatter {
    
    func customDateFormatter(date: String) -> DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: date) ?? Date()
        let dateComps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return dateComps
    }
}
