//
//  String+Extension.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/27/24.
//

import Foundation

extension String {
    var stringToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            return date.exactDate
        } else {
            return .now.exactDate
        }
    }
}
