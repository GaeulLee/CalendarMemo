//
//  HomeView.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var pathModel: PathModel
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some View {
        ZStack {
            TabView(selection: $homeVM.selectedTab) {
                CalendarView()
                    .tabItem {
                        // TODO: - find icon for tab item
                        Image(systemName: "calendar")
                            .renderingMode(.template)
                            .accentColor(homeVM.selectedTab == .calendar ? .customDarkGreen : .customBrightGreen)
                    }.tag(Tab.calendar)
                
                MemoListView()
                    .tabItem {
                        Image(systemName: "doc.text")
                            .renderingMode(.template)
                            .foregroundColor(homeVM.selectedTab == .memo ? .customDarkGreen : .customBrightGreen)
                    }.tag(Tab.memo)
            }
            .environmentObject(homeVM)
            
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
                    .padding(.bottom, 60)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(PathModel())
        .environmentObject(CalendarViewModel())
        .environmentObject(MemoListViewModel())
}
