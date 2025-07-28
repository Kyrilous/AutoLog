//
//  AutoLogApp.swift
//  AutoLog
//
//  Created by Kero Nasr on 7/28/25.
//

import SwiftUI

@main
struct AutoLogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
