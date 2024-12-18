//
//  MemoListView.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListVM: MemoListViewModel // memoView에서도 사용해야 하기 때문!
    
    var body: some View {
        ZStack {
            VStack {
                // naviBar
                if memoListVM.memos.isEmpty {
                    Spacer()
                        .frame(height: 38)
                } else {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: { memoListVM.navigationBarBtnTapped() },
                        rightBtnType: memoListVM.naviBarBtnMode
                    )
                }
                
                TitleView()
                
                // content
                if memoListVM.memos.isEmpty {
                    ListWithNoMemosView()
                } else {
                    ListView()
                }
            }
            
            // createMemoBtn
            CreateMemoBtnView()
        }
        .background(Color.defalutBackground)
        .alert("선택한 메모를 삭제하겠습니까?",
               isPresented: $memoListVM.isDisplayDeleteAlert) {
            Button("삭제", role: .destructive) { memoListVM.alertDeleteBtnTapped() }
            Button("취소", role: .cancel) {}
        }

    }
}

private struct TitleView: View {
    fileprivate var body: some View {
        HStack {
            Text("전체 메모 목록")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.defaultFont)
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
}


// MARK: - List(no memo)
private struct ListWithNoMemosView: View {
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            Text("작성된 메모가 없습니다.")
                .font(.system(size: 16))
                .foregroundColor(.defaultFont)
            
            Spacer()
        }
        .padding(.bottom, 50)
    }
}

// MARK: - List
private struct ListView: View {
    @EnvironmentObject private var memoListVM: MemoListViewModel
    
    fileprivate var body: some View {
        // list
        Rectangle()
            .fill(Color.placeholder)
            .frame(height: 1)
        
        ScrollView(.vertical) {
            VStack {
                ForEach(memoListVM.memos, id: \.self) { memo in
                    ListCellView(memo: memo)
                    
                    Rectangle()
                        .fill(Color.placeholder)
                        .frame(height: 1)
                }
            }

        }
    }
}

private struct ListCellView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListVM: MemoListViewModel
    @State private var isCheckedForDelete: Bool
    private var memo: Memo
    
    fileprivate init(isCheckedForDelete: Bool = false, memo: Memo) {
        _isCheckedForDelete = State(initialValue: isCheckedForDelete)
        self.memo = memo
    }
    
    fileprivate var body: some View {
        Button(
            action: { pathModel.paths.append(.memoView(isCreateMode: false, memo: memo)) },
            label: {
                HStack(spacing: 15) {
                    if !memoListVM.isDeleteMode {
                        Button(
                            action: { memoListVM.defaultCheckboxTapped(memo) },
                            label: {
                                Image(memo.isChecked ? "checkBox_checked" : "checkBox")
                            }
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(memo.title)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(memo.isChecked ? .customDarkBeige : .defaultFont)
                            .strikethrough(memo.isChecked)
                        
                        Text(memo.convertedContent)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.customDarkGray)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }

                    Spacer()
                    
                    if memoListVM.isDeleteMode {
                        Button(
                            action: {
                                isCheckedForDelete.toggle()
                                memoListVM.deleteCheckboxTapped(memo)
                            },
                            label: {
                                Image(isCheckedForDelete ? "checkBox_checked" : "checkBox")
                            }
                        )
                    }
                    
                }
                .padding(.top, 5)
                .padding(.bottom, 5)
                .padding(.horizontal, 20)
            }
        )
    }
}

// MARK: - CreateMemoBtn
private struct CreateMemoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button(
                    action: { pathModel.paths.append(.memoView(isCreateMode: true, memo: nil)) },
                    label: {
                        HStack(spacing: 6) {
                            Image("plus")
                            Text("새 메모")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                )
                .padding(10)
                .background(Color.customDarkGreen)
                .cornerRadius(13)
                
            }
            .padding(.trailing, 20)
        }
        .padding(.bottom, 50)
    }
}




#Preview {
    MemoListView()
        .environmentObject(PathModel())
        .environmentObject(MemoListViewModel())
}
