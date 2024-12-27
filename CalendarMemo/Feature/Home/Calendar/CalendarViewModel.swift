//
//  CalendarViewModel.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

class CalendarViewModel: ObservableObject {
    @Published var month: Date
    @Published var selectedDate: Date?
    
    var weekdaySymbols: [String] {
        var cal = Calendar.current
        cal.locale = Locale(identifier: "ko_KR")
        return cal.veryShortWeekdaySymbols  // 일,월 ... 금, 토
    }
    
    init(month: Date = .now,
         selectedDate: Date? = nil
    ) {
        self.month = month
        self.selectedDate = selectedDate
    }
}

extension CalendarViewModel {
    
    /// startDayOfMonth에 해당하는 날짜에서 '일' 단위로 계산(입력받은 정수를 더함)해서 Date 타입으로 반환 -> day가 2라면 12/02
    func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startDayOfMonth())!
        
    }
    
    /// month의 시작 날짜 Date 타입으로 반환 -> 2024/12/01... (실제 값은 11/30이 나옴)
    func startDayOfMonth() -> Date {
        // month에 해당하는 날짜 요소를 반환 -> month가 2024/12/11... 의 값이라면 year: 2024, month: 12
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수 -> 12월이면 31 반환
    func numberOfDays(in date: Date) -> Int {
      return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 특정 달의 첫째주 시작 요일 반환 -> 월요일이라면 2
    func firstWeekdayOfMonth(for date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    func changeMonth(by value: Int) {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
}
