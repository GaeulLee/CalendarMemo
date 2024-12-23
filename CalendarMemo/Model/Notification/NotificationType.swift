//
//  Notification.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/18/24.
//

import Foundation

@objc
public enum NotificationType: Int32, CaseIterable, Identifiable {
    // core data 에서 열거형을 쓰는게 꽤 까다로움,, 어쩔 수 없이 문자열이 아닌 정수로 받았다..
    // 다른 방법이 있었을까ㅠㅜ
    case noNoti = 0
    case onTheDay = 1
    case aDayBefore = 2
    case twoDaysBefore = 3
    
    public var id: Int32 { self.rawValue }
}
