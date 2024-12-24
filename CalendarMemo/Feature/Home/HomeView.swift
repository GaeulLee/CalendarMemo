//
//  HomeView.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $homeVM.selectedTab) {
                CalendarView()
                    .tabItem {
                        Image(homeVM.selectedTab == .calendar ? "calendar_selected" : "calendar")
                    }.tag(Tab.calendar)
                
                MemoListView()
                    .tabItem {
                        Image(homeVM.selectedTab == .memo ? "list_selected" : "list")
                    }.tag(Tab.memo)
            }
            
            VStack {
                Spacer()
                
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.defalutBackground, Color.gray.opacity(0.1)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 10)
                    .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(MemoListViewModel())
}
