//
//  MemoViewModel.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memo: Memo
    @Published var isDisplayCalendar: Bool
    
    private let notiService = NotificationService()

    init(memo: Memo, isDisplayCalendar: Bool = false) {
        self.memo = memo
        self.isDisplayCalendar = isDisplayCalendar
    }
}

extension MemoViewModel {
    func setDisplayCalendar(_ isDisplay: Bool) {
        isDisplayCalendar = isDisplay
    }
    
    func changeDate(date: Date) {
        memo.date = date
    }
    
    func setNotification(memo: Memo) {
        if memo.notificatoinType == .noNoti { // 알림 설정 안 함이면 삭제
            deleteNotification(id: memo.id)
        } else { // 그 외이면 삭제하고 알림 생성
            deleteNotification(id: memo.id)
            notiService.setNotification(memo: memo)
        }
    }
    
    func deleteNotification(id: String) {
        notiService.removePendingNotification(identifier: id)
    }
}
