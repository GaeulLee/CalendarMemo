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
    
    var exactDate: Date {
        let timeZone = TimeZone.current
        var date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
        return date.addingTimeInterval(TimeInterval(timeZone.secondsFromGMT(for: date)))
    }
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return "\(dateFormatter.string(from: self))"
    }
}
