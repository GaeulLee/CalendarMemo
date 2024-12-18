//
//  MemoListViewModel.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation

class MemoListViewModel: ObservableObject {
    @Published var memos: [Memo]
    @Published var deleteMemos: [Memo]
    @Published var isDeleteMode: Bool
    @Published var isDisplayDeleteAlert: Bool
    
    var naviBarBtnMode: NavigationBtnType {
        return isDeleteMode ? .delete : .edit
    }
    
    init(memos: [Memo] = [],
         deleteMemos: [Memo] = [],
         isDeleteMode: Bool = false,
         isDisplayDeleteAlert: Bool = false
    ) {
        self.memos = memos
        self.deleteMemos = deleteMemos
        self.isDeleteMode = isDeleteMode
        self.isDisplayDeleteAlert = isDisplayDeleteAlert
    }
}

extension MemoListViewModel {
    // add
    func addMemo(_ memo: Memo) {
        if isVaild(memo) {
            memos.append(memo)
        }
    }
    
    // update
    func updateMemo(_ memo: Memo) {
        if isVaild(memo) {
            if let index = memos.firstIndex(where: { $0.id == memo.id }) {
                memos[index] = memo
            }
        }
    }
    
    // delete
    func deleteMemo(_ memo: Memo) {
        if let index = memos.firstIndex(where: { $0.id == memo.id }) {
            memos.remove(at: index)
        }
    }
    
    func defaultCheckboxTapped(_ memo: Memo) {
        if let index = memos.firstIndex(of: memo) {
            memos[index].isChecked.toggle()
        }
    }
    
    // deleteCheckboxTapped
    func deleteCheckboxTapped(_ memo: Memo) {
        if let index = deleteMemos.firstIndex(of: memo) {
            deleteMemos.remove(at: index)
        } else {
            deleteMemos.append(memo)
        }
    }
    
    // delete memos when deleteBtn tapped
    func alertDeleteBtnTapped() {
        memos.removeAll { memo in
            deleteMemos.contains(memo)
        }
        deleteMemos.removeAll()
        isDeleteMode = false
    }
    
    // navigationBarBtnAction
    func navigationBarBtnTapped() {
        if isDeleteMode {
            if deleteMemos.isEmpty {
                isDeleteMode = false
            } else {
                setDeleteAlertDisplay(true)
            }
        } else {
            isDeleteMode = true
        }
    }
    
    // setDeleteAlertDisplay
    func setDeleteAlertDisplay(_ isDisplay: Bool) {
        isDisplayDeleteAlert = isDisplay
    }
    
    // vaildCheck
    func isVaild(_ memo: Memo) -> Bool {
        if memo.title != "" && memo.content != "" {
            return true
        } else {
            return false
        }
    }
}
