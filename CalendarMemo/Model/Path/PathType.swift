//
//  PathType.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

enum PathType: Hashable { // ⭐️ Hashable: NavigationStack에서 PathType 배열 사용할거니까
    case homeView
    case memoView(isCreateMode: Bool, memo: Memo?, selectedDate: Date?)
}
