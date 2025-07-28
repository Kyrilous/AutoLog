//
//  DetailView.swift
//  AutoLog
//
//  Created by Kero Nasr on 7/27/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    let entry: MaintenanceEntry

    var body: some View {
        NavigationView {
            Form {
                Section("Service") {
                    Text(entry.serviceType ?? "-")
                    Text("Mileage: \(entry.mileage)")
                }
                Section("When") {
                    if let date = entry.date {
                        Text(date, formatter: itemFormatter)
                    }
                }
                Section("Notes") {
                    Text(entry.notes ?? "No notes")
                }
                Section("Next Service Scheduled For"){
                    if let date = entry.reminderDate {
                        Text(date, formatter: itemFormatter)
                    }else {
                        Text("No reminder set")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Details")
    
            
        }
    }
}

private let itemFormatter: DateFormatter = {
    let f = DateFormatter()
    f.dateStyle = .short
    f.timeStyle = .none
    return f
}()
