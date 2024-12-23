//
//  CalendarMemoApp.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/16/24.
//

import SwiftUI

@main
struct CalendarMemoApp: App {
    //let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

