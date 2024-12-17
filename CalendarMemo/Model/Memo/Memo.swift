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
    
    // 날짜 변환
    
    // 변환 날짜 + 메모 컨텐츠 -> 리스트용
}
