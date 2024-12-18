//
//  Memo.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

struct Memo: Hashable {
    var id: UUID
    var title: String
    var content: String
    var date: Date
    var isChecked: Bool
    var notificatoinType: NotificationType
    
    init(id: UUID = UUID(),
         title: String,
         content: String,
         date: Date = .now,
         isChecked: Bool = false,
         notificatoinType: NotificationType = .noNoti
    ) {
        self.id = id
        self.date = date
        self.isChecked = isChecked
        self.notificatoinType = notificatoinType
        self.title = title
        self.content = content
    }
    
    // 날짜 변환
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy/MM/dd" // 24/09/12
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    
    // 변환 날짜 + 메모 컨텐츠 -> 리스트용
    var convertedContent: String {
        return "\(formattedDate), \(content)"
    }
}
