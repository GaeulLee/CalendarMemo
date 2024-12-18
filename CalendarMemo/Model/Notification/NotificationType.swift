//
//  Notification.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/18/24.
//

import Foundation

enum NotificationType: String, CaseIterable, Identifiable {
    case noNoti = "설정 안 함"
    case onTheDay = "당일(오전 9시)"
    case aDayBefore = "하루 전(오전 9시)"
    case twoDaysBefore = "이틀 전(오전 9시)"
    
    var id: String { self.rawValue }
}
