//
//  AutoLogApp.swift
//  AutoLog
//
//  Created by Kero Nasr on 7/28/25.
//

import SwiftUI

@main
struct AutoLogApp: App {
    let persistence = PersistenceController.shared
    @StateObject private var session: UserSession

    init() {
        let ctx = persistence.container.viewContext
        _session = StateObject(wrappedValue: UserSession(context: ctx))
        ReminderScheduler.shared.requestAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .environmentObject(session)
        }
    }
}

