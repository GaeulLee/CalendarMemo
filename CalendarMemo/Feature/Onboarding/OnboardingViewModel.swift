//
//  OnboardingViewModel.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var content: [OnboardingContent]
    
    init(content: [OnboardingContent] = [
        OnboardingContent(imageFileName: "onboarding1", content: "달력에 적는 나만의 메모"),
        OnboardingContent(imageFileName: "onboarding2", content: "모든 메모가 한 눈에"),
        OnboardingContent(imageFileName: "onboarding3", content: "메모 미리 알림까지")
    ]
    ) {
        self.content = content
    }
}
