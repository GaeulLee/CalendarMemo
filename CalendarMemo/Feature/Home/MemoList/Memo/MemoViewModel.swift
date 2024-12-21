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
    
    private var notiService = NotificationService()

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
        if notiService.findPendingNotification(id: memo.id) { // 설정한 알림이 있으면
            notiService.removePendingNotification(identifier: memo.id) // 삭제하고
            notiService.setNotification(memo: memo) // 다시 생성
        } else { // 없으면
            notiService.setNotification(memo: memo) // 생성
        }
        
        notiService.test()
    }
    
    func deleteNotification(id: String) {
        if notiService.findPendingNotification(id: id) {
            notiService.removePendingNotification(identifier: id)
        }
    }
}
