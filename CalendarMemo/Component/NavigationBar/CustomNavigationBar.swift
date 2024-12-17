//
//  CustomNavigationBar.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import SwiftUI

import SwiftUI

struct CustomNavigationBar: View {
    // 네비게이션 바 버튼 표시 여부
    let isDisplayLeftBtn: Bool // 뒤로가기
    let isDisplayrightBtn: Bool // 생성 완료 편집 삭제
    
    // 네비게이션 바 버튼의 액션을 담을 변수
    let leftBtnAction: () -> Void
    let rightBtnAction: () -> Void
    
    let  rightBtnType: NavigationBtnType // 우측 네비게이션 바 버튼애 들어갈 내용
    
    init(isDisplayLeftBtn: Bool = true,
         isDisplayrightBtn: Bool = true,
         leftBtnAction: @escaping () -> Void = {},
         rightBtnAction: @escaping () -> Void = {},
         rightBtnType: NavigationBtnType = .edit
    ) {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayrightBtn = isDisplayrightBtn
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
        self.rightBtnType = rightBtnType
    }
    
    var body: some View {
        HStack {
            if isDisplayLeftBtn {
                Button(
                    action: leftBtnAction,
                    label: { 
                        Image("backArrow")
                            .renderingMode(.template)
                            .foregroundColor(.customDarkGreen)
                    }
                )
            }
            
            Spacer()
            
            if isDisplayrightBtn {
                Button(
                    action: rightBtnAction,
                    label: {
                            Text("\(rightBtnType.rawValue)")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color.customDarkGreen)
                    }
                )
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 30)
    }
}

#Preview {
    CustomNavigationBar()
}
