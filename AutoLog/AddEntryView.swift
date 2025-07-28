//
//  AddEntryView.swift
//  AutoLog
//
//  Created by Kero Nasr on 7/27/25.
//

import SwiftUI
import CoreData

struct AddEntryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var serviceType = ""
    @State private var mileage = ""
    @State private var date = Date()
    @State private var notes = ""
    @State private var reminderDate = Date()
    @State private var wantsReminder = false
    

    var body: some View {
        NavigationView {
            Form {
                Section("Service") {
                    TextField("Type (e.g. Oil Change)", text: $serviceType)
                    TextField("Mileage", text: $mileage)
                        .keyboardType(.numberPad)
                }
                Section("When") {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                }
                Section("Reminder") {
                  Toggle("Remind me", isOn: $wantsReminder)
                  if wantsReminder {
                    DatePicker("On…", selection: $reminderDate, displayedComponents: .date)
                  }
                }

            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let entry = MaintenanceEntry(context: viewContext)
                        entry.serviceType = serviceType
                        entry.mileage = Int64(mileage) ?? 0
                        entry.date = date
                        entry.notes = notes
                        entry.reminderDate = wantsReminder ? reminderDate : nil
                        ReminderScheduler.shared.cancelReminder(for: entry)
                        if entry.reminderDate != nil {
                          ReminderScheduler.shared.scheduleReminder(for: entry)
                        }
                        do {
                            try viewContext.save()
                            dismiss()
                        } catch {
                            print("Error saving entry:", error)
                        }
                    }
                    .disabled(serviceType.isEmpty || mileage.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
