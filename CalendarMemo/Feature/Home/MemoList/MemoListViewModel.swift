//
//  MemoListViewModel.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import Foundation
import CoreData

class MemoListViewModel: ObservableObject {
    let container: NSPersistentContainer
    let entityName = "MemoData"
    
    //@Published var memos: [Memo]
    @Published var memos = [MemoData]()
    @Published var deleteMemos: [MemoData]
    @Published var isDeleteMode: Bool
    @Published var isDisplayDeleteAlert: Bool
    
    var naviBarBtnMode: NavigationBtnType {
        return isDeleteMode ? .delete : .edit
    }
    
    init (deleteMemos: [MemoData] = [],
          isDeleteMode: Bool = false,
          isDisplayDeleteAlert: Bool = false
    ) {
        self.deleteMemos = deleteMemos
        self.isDeleteMode = isDeleteMode
        self.isDisplayDeleteAlert = isDisplayDeleteAlert
        
        container = NSPersistentContainer(name: entityName)
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA")
                print(error.localizedDescription)
            } else {
                print("SUCCESSFULLY LOAD CORE DATA")
            }
        }
        fetchMemos()
    }
}

extension MemoListViewModel {
    func fetchMemos() {
        let request = NSFetchRequest<MemoData>(entityName: entityName)
        do {
            memos = try container.viewContext.fetch(request)
            for memo in memos {
                dump(memo)
            }
            print("SUCCESSFULLY FETCHED CORE DATA")
        } catch {
            print("ERROR FETCHING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            print("SUCCESSFULLY SAVED CORE DATA")
            fetchMemos()
        } catch {
            print("ERROR SAVING CORE DATA")
            print(error.localizedDescription)
        }
    }
    
    func addMemo(_ memo: Memo) {
        if isVaild(memo) {
            print("\(#function) start ======================")
            
            let memoData = MemoData(context: container.viewContext)
            memoData.id = memo.id
            memoData.title = memo.title
            memoData.content = memo.content
            memoData.date = memo.date.dateToString()
            memoData.isChecked = memo.isChecked
            memoData.notificationType = memo.notificationType
            
            print("=======> \(memoData)")
            
            saveData()
            print("\(#function) done ======================")
        }
    }
    
    func updateMemo(_ memo: Memo) {
        if isVaild(memo) {
            if let index = memos.firstIndex(where: { $0.id == memo.id }) {
                print("\(#function) start ======================")
                
                let memoData = memos[index]
                memoData.title = memo.title
                memoData.content = memo.content
                memoData.date = memo.date.dateToString()
                memoData.isChecked = memo.isChecked
                memoData.notificationType = memo.notificationType
                
                print("=======> \(memoData)")
                
                saveData()
                print("\(#function) done ======================")
            }
        }
    }

    func deleteMemo(_ memo: Memo) {
        print("\(#function) start ======================")
        if let index = memos.firstIndex(where: { $0.id == memo.id }) {
            container.viewContext.delete(memos[index])
            
            saveData()
            print("\(#function) done ======================")
        }
    }
    
    
    func isMemoWritten(date: Date) -> Bool {
        if let memo = memos.first(where: { $0.date == date.dateToString() }) {
            return true
        } else {
            return false
        }
    }
    
    func defaultCheckboxTapped(_ memo: MemoData) {
        if let index = memos.firstIndex(of: memo) {
            memos[index].isChecked.toggle()
            
            saveData()
        }
    }
    
    // deleteCheckboxTapped
    func deleteCheckboxTapped(_ memo: MemoData) {
        if let index = deleteMemos.firstIndex(of: memo) {
            deleteMemos.remove(at: index)
        } else {
            deleteMemos.append(memo)
        }
    }
    
    // delete memos when deleteBtn tapped
    func alertDeleteBtnTapped() {
        for memo in memos {
            if deleteMemos.contains(memo) {
                container.viewContext.delete(memo)
            }
        }
        deleteMemos.removeAll()
        isDeleteMode = false
        
        saveData()
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
