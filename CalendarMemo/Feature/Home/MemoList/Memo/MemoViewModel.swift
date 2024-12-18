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

    init(memo: Memo, isDisplayCalendar: Bool = false) {
        self.memo = memo
        self.isDisplayCalendar = isDisplayCalendar
    }
}

extension MemoViewModel {
    func setDisplayCalendar(_ isDisplay: Bool) {
        isDisplayCalendar = isDisplay
    }
}
