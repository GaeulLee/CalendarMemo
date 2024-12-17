//
//  Path.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []
    ) {
        self.paths = paths
    }
}
