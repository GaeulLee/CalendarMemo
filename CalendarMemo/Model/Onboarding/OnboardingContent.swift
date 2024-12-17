//
//  OnboardingContent.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

struct OnboardingContent: Hashable {
    var imageFileName: String
    var content: String
    
    init(imageFileName: String, content: String) {
        self.imageFileName = imageFileName
        self.content = content
    }
}
