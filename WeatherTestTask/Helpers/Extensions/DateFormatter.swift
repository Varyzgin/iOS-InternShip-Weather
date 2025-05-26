//
//  DateFormatter.swift
//  WeatherTestTask
//
//  Created by Dim on 26.05.2025.
//

import Foundation

extension DateFormatter {
    static func formatDate(from string: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "ru_RU")

        guard let date = inputFormatter.date(from: string) else { return string }

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ru_RU")
        outputFormatter.setLocalizedDateFormatFromTemplate("d MMM")

        let formatted = outputFormatter.string(from: date)
        let components = formatted.split(separator: " ")

        if components.count == 2 {
            return "\(components[0])\n\(components[1])"
        } else {
            return formatted
        }
    }
}
