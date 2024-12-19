//
//  HomeViewModel.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab
    
    init(selectedTab: Tab = .calendar) {
        self.selectedTab = selectedTab
    }
}

extension HomeViewModel {
    func changeTab(to tab: Tab) {
        selectedTab = tab
    }
}
