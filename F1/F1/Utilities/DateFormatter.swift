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

    func customLocalTimeFormatter(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let formattedTime = dateFormatter.date(from: time) else {
            return "Error"
        }

        let localDateFormatter = DateFormatter()
        localDateFormatter.dateFormat = "HH:mm:ss"
        localDateFormatter.timeZone = TimeZone.current
        let localTimeString = localDateFormatter.string(from: formattedTime)

        return localTimeString
    }
}
