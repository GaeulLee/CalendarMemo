//
//  Memo.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

struct Memo: Hashable {
    var id: String
    var title: String
    var content: String
    var date: Date
    var isChecked: Bool
    var notificatoinType: NotificationType
    
    init(id: String = UUID().uuidString,
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
    
    // 변환 날짜 + 메모 컨텐츠 -> 리스트용
    var convertedContent: String {
        return "\(date.formattedDateForMemo), \(content)"
    }
}
