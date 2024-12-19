//
//  CalendarView.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListVM: MemoListViewModel
    @StateObject private var calendarVM = CalendarViewModel()
    
    var body: some View {
        VStack {
            // calendar
            CalendarHeaderView(calendarVM: calendarVM)
                .padding(.top, 25)
            
            CalendarGridView(calendarVM: calendarVM)
                .frame(height: 270)
            
            // memo on the day(달력에서 선택한 날의 메모를 보여 줌, 기본은 오늘)
            MemoTitleView()
            
            MemoListContentView(calendarVM: calendarVM)
        }
        .background(Color.defalutBackground)
    }
}

// MARK: - CalendarHeader
private struct CalendarHeaderView: View {
    @ObservedObject private var calendarVM: CalendarViewModel
    
    fileprivate init(calendarVM: CalendarViewModel) {
        self.calendarVM = calendarVM
    }
    
    fileprivate var body: some View {
        VStack {
            // date
            HStack(spacing: 5) {
                Button(
                    action: { calendarVM.changeMonth(by: -1) },
                    label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.customDarkGreen)
                    }
                )
                
                Text(calendarVM.month.formattedDateForCalendar)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.defaultFont)
                    .monospacedDigit()
                
                Button(
                    action: { calendarVM.changeMonth(by: 1) },
                    label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.customDarkGreen)
                    }
                )
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            
            // weekdays
            HStack() {
                ForEach(calendarVM.weekdaySymbols, id: \.self) { symbol in
                  Text(symbol)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 16))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 5)
        }
    }
}

// MARK: - CalendarGrid
private struct CalendarGridView: View {
    @ObservedObject private var calendarVM: CalendarViewModel
    
    fileprivate init(calendarVM: CalendarViewModel) {
        self.calendarVM = calendarVM
    }
    
    fileprivate var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                let daysInMonth: Int = calendarVM.numberOfDays(in: calendarVM.month) // 해당 달의 일 수
                let firstWeekday: Int = calendarVM.firstWeekdayOfMonth(for: calendarVM.month) - 1 // 첫째주 첫요일
                // 화요일이면 3, foreach 인덱스 돌기 위해 -1 해줌
                
                ForEach(0..<daysInMonth + firstWeekday, id: \.self) { index in
                    if index < firstWeekday { // 첫째주 첫요일까지 빈공간
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.clear)
                    } else {
                        //let date = calendarVM.getDate(for: index - firstWeekday)
                        let day = index - firstWeekday + 1
                        CalendarGridCellView(calendarVM: calendarVM, day: day)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - CalendarGridCell
private struct CalendarGridCellView: View {
    @EnvironmentObject private var memoListVM: MemoListViewModel
    @ObservedObject private var calendarVM: CalendarViewModel
    @State private var isClicked: Bool
    var day: Int

    fileprivate init(calendarVM: CalendarViewModel, isClicked: Bool = false, day: Int) {
        self.calendarVM = calendarVM
        _isClicked = State(initialValue: isClicked)
        self.day = day
    }
    
    fileprivate var body: some View {
        Button(
            action: {
                calendarVM.dayBtnTapped(calendarVM.getDate(for: day), memoListVM.memos)
            },
            label: {
                Text(String(day))
                    .foregroundColor(.defaultFont)
                    .font(.system(size: 16))
            }
        )
    }
}


// MARK: - MemoTitle
private struct MemoTitleView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("메모 목록")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.defaultFont)
                
                Spacer()
                
                Button(
                    action: { pathModel.paths.append(.memoView(isCreateMode: true, memo: nil)) },
                    label: {
                        Image("plus")
                            .renderingMode(.template)
                            .foregroundColor(.customDarkGreen)
                    }
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Rectangle()
                .fill(Color.placeholder)
                .frame(height: 1)
        }
    }
}

// MARK: - MemoListContent
private struct MemoListContentView: View {
    @EnvironmentObject private var memoListVM: MemoListViewModel
    @ObservedObject private var calendarVM: CalendarViewModel
    
    fileprivate init(calendarVM: CalendarViewModel) {
        self.calendarVM = calendarVM
    }
    
    fileprivate var body: some View  {
        VStack {
            if calendarVM.memosOnTheDay.isEmpty {
                Spacer()
                
                Text("작성된 메모가 없습니다.")
                    .font(.system(size: 16))
                    .foregroundColor(.defaultFont)
                    .padding(.bottom, 50)
                
                Spacer()
            } else {
                ScrollView(.vertical) {
                    ForEach(calendarVM.memosOnTheDay, id: \.self) { memo in
                        MemoListContentCellView(memo: memo)
                        
                        Rectangle()
                            .fill(Color.placeholder)
                            .frame(height: 1)
                    }
                    
                }
                
            }
        }
    }
}

// MARK: - MemoListContentCell
private struct MemoListContentCellView: View {
    @EnvironmentObject private var pathModel: PathModel
    @EnvironmentObject private var memoListVM: MemoListViewModel
    private var memo: Memo

    fileprivate init(memo: Memo) {
        self.memo = memo
    }
    
    fileprivate var body: some View {
        Button(
            action: { pathModel.paths.append(.memoView(isCreateMode: false, memo: memo)) },
            label: {
                HStack(spacing: 15) {
                    Button(
                        action: { memoListVM.defaultCheckboxTapped(memo) },
                        label: { Image(memo.isChecked ? "checkBox_checked" : "checkBox") }
                    )
                    
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
                }
                .padding(.top, 5)
                .padding(.bottom, 5)
                .padding(.horizontal, 20)
            }
        )
    }
}

#Preview {
    CalendarView()
        .environmentObject(PathModel())
        .environmentObject(MemoListViewModel())
}
