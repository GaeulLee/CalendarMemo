//
//  MemoView.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/17/24.
//

import SwiftUI

struct MemoView: View {
    @EnvironmentObject private var pathModel: PathModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Hello, World!")
            
            Button {
                pathModel.paths.removeLast()
            } label: {
                Text("back")
            }

            
            Spacer()
        }
        
    }
}

#Preview {
    MemoView()
        .environmentObject(PathModel())
}
