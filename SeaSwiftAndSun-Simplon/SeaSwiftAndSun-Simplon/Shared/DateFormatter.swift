//
//  DateFormatter.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 14/12/2023.
//

import Foundation

func formatDate(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"

    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return outputFormatter.string(from: date)
    } else {
        return nil
    }
}
