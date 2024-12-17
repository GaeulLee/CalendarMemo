//
//  OnboardingView.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var onboardingVM = OnboardingViewModel()
    
    var body: some View {
        OnboardingContentView(onboardingVM: onboardingVM)
        
        // navi
        

    }
}
// MARK: - OnboardingContent
private struct OnboardingContentView: View {
    @ObservedObject private var onboardingVM : OnboardingViewModel
    
    fileprivate init(onboardingVM: OnboardingViewModel) {
        self.onboardingVM = onboardingVM
    }
    
    fileprivate var body: some View {
        ZStack {
            VStack {
                IndicatorView(onboardingVM: onboardingVM)
                
                OnboardingTabView(onboardingVM: onboardingVM)
            }
            
            StartBtnView()
        }
    }
}
// MARK: - Indicator
private struct IndicatorView: View {
    @ObservedObject private var onboardingVM : OnboardingViewModel
    
    fileprivate init(onboardingVM: OnboardingViewModel) {
        self.onboardingVM = onboardingVM
    }
    
    fileprivate var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<onboardingVM.contents.count, id: \.self) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(index == onboardingVM.selectedIndex 
                                     ? .customDarkGreen
                                     : .customDarkGreen.opacity(0.3))
            }
        }
        .padding(.top, 20)
    }
}

// MARK: - OnboardingTab
private struct OnboardingTabView: View {
    @ObservedObject private var onboardingVM : OnboardingViewModel
    
    fileprivate init(onboardingVM: OnboardingViewModel) {
        self.onboardingVM = onboardingVM
    }
    
    fileprivate var body: some View {
        TabView(selection: $onboardingVM.selectedIndex) {
            ForEach(Array(onboardingVM.contents.enumerated()), id: \.element) { index, content in
                OnboardingCellView(content: content)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        
    }
}



// MARK: - OnboardingCell
private struct OnboardingCellView: View {
    private var content: OnboardingContent
    
    fileprivate init(content: OnboardingContent) {
        self.content = content
    }
    
    fileprivate var body: some View {
        VStack {
            Text(content.content)
                .font(.system(size: 20, weight: .bold))
            
            Image(content.imageFileName)
                .resizable()
                .frame(width: 310, height: 610)
        }
        .padding(.top, 30)
    }
}



// MARK: - StartBtn
private struct StartBtnView: View {
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(
                    action: {  },
                    label: {
                        HStack {
                            Text("시작하기")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.customDarkGreen)
                            Image("rightArrow")
                                .renderingMode(.template)
                                .foregroundColor(.customDarkGreen)
                        }
                    }
                )
            }
            .frame(width: 500, height: 65)
            .background(.customBeige)
        }
    }
}

#Preview {
    OnboardingView()
}
