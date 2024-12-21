//
//  Date+Extension.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/19/24.
//

import Foundation

extension Date {
    // 날짜 변환
    var formattedDateForMemo: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd" // 24/09/12
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
    
    var formattedDateForCalendar: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM" // 2024.12
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
    
    var onlyDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
}
