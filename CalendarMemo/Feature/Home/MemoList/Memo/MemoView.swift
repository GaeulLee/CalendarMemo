//
//  MemoView.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import SwiftUI

struct MemoView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListVM: MemoListViewModel
    @StateObject var memoVM: MemoViewModel
    @State var isCreateMode: Bool
    
    var body: some View {
        ZStack {
            VStack {
                // naviBar
                CustomNavigationBar(
                    leftBtnAction: { pathModel.paths.removeLast() },
                    rightBtnAction: { 
                        if isCreateMode {
                            memoListVM.addMemo(memoVM.memo)
                            pathModel.paths.removeLast()
                        } else {
                            memoListVM.updateMemo(memoVM.memo)
                            pathModel.paths.removeLast()
                        }
                    },
                    rightBtnType: isCreateMode ? .create : .complete
                )
                .padding(.bottom, 10)
                
                // titleInput
                TitleInputView(memoVM: memoVM, isCreateMode: $isCreateMode)
                
                // contentInput
                ContentInputView(memoVM: memoVM)
                
            }
            // bottomSection
            BottomSectionView(memoVM: memoVM)
        }
        .background(Color.defalutBackground)
        
    }
}

// MARK: - TitleInput
private struct TitleInputView: View {
    @ObservedObject private var memoVM: MemoViewModel
    @FocusState private var isTitleInputFocused: Bool // ⭐️
    @Binding private var isCreateMode: Bool
    
    fileprivate init(memoVM: MemoViewModel, isCreateMode: Binding<Bool>) {
        self.memoVM = memoVM
        self._isCreateMode = isCreateMode
    }
    
    fileprivate var body: some View {
        TextField(
            "제목을 입력하세요.",
            text: $memoVM.memo.title
        )
        .font(.system(size: 22, weight: .bold))
        .foregroundColor(.defaultFont)
        .padding(.horizontal, 20)
        .focused($isTitleInputFocused) // ⭐️
        .onAppear { // TitleInputView가 나타났을 때 아래 코드 진행
            if isCreateMode {
                isTitleInputFocused = true
            }
        }
    }
}

// MARK: - ContentInput
private struct ContentInputView: View {
    @ObservedObject private var memoVM: MemoViewModel
    
    fileprivate init(memoVM: MemoViewModel) {
        self.memoVM = memoVM
    }
    
    fileprivate var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $memoVM.memo.content)
                .font(.system(size: 18))
                .foregroundColor(.defaultFont)
                .scrollContentBackground(.hidden)
            
            if memoVM.memo.content.isEmpty { // palceholer
                Text("메모를 입력하세요.")
                    .font(.system(size: 18))
                    .foregroundColor(.placeholder)
                    .allowsHitTesting(false)
                    .padding(.top, 10)
                    .padding(.leading, 5)
            }
        }
        .padding(.horizontal, 20)
        
    }
}

// MARK: - BottomSection
private struct BottomSectionView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListVM: MemoListViewModel
    @ObservedObject private var memoVM: MemoViewModel

    fileprivate init(memoVM: MemoViewModel) {
        self.memoVM = memoVM
    }
    
    fileprivate var body: some View {
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
            
            HStack {
                VStack(alignment: .leading, spacing: 1) {
                    // calendar
                    HStack(spacing: 15) {
                        Text("날짜")
                            .font(.system(size: 16))
                            .foregroundColor(.defaultFont)
                        
                        DatePicker(
                            "date",
                            selection: $memoVM.memo.date,
                            displayedComponents: [.date]
                        )
                        .labelsHidden()
                        .accentColor(.customDarkGreen)
                        .foregroundColor(.customDarkGreen)
                    }
                    
                    // noti
                    HStack(spacing: 10) {
                        Text("알림")
                            .font(.system(size: 16))
                            .foregroundColor(.defaultFont)
                            
                        Picker("알림", selection: $memoVM.memo.notificatoinType) {
                            ForEach(NotificationType.allCases) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(.menu)
                        .accentColor(.customDarkGreen)
                    }
                }
                .padding(.leading, 20)
                .padding(.top, 5)
                
                Spacer()
                
                // deleteBtn
                Button(
                    action: {
                        memoListVM.deleteMemo(memoVM.memo)
                        pathModel.paths.removeLast()
                    },
                    label: {
                        Image("trash")
                            .renderingMode(.template)
                            .foregroundColor(.customDarkGreen)
                    }
                )
                .padding(.trailing, 20)
            }
            .frame(height: 70)
        }
    }
}


#Preview {
    MemoView(memoVM: MemoViewModel(memo: Memo(title: "", content: "")),
             isCreateMode: false)
}
