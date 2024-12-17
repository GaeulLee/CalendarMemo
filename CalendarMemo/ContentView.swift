//
//  ContentView.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Spacer()
                .frame(height: 50)
            
            HStack(spacing: 60) {
                Image(systemName: "calendar")
                Image(systemName: "list.bullet")
                Image(systemName: "list.dash.header.rectangle")
            }
            .imageScale(.large)
            .foregroundStyle(.customGreen)
            
            
            Spacer()
                .frame(height: 50)
            
            HStack(spacing: 60) {
                Image(systemName: "calendar")
                Image(systemName: "list.bullet")
                Image(systemName: "list.dash.header.rectangle")
            }
            .imageScale(.large)
            .foregroundStyle(.customDarkGreen)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
