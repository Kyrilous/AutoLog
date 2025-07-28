//
//  ContentView.swift
//  AutoLog
//
//  Created by Kero Nasr on 7/28/25.
//


import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MaintenanceEntry.date, ascending: false)],
        animation: .default
    )
    private var entries: FetchedResults<MaintenanceEntry>

    @State private var showingAddEntry = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(entries) { entry in
                    NavigationLink(destination: DetailView(entry: entry)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(entry.serviceType ?? "–")
                                    .font(.headline)
                                Text("Mileage: \(entry.mileage)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            if let date = entry.date {
                                Text(date, formatter: itemFormatter)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete(perform: deleteEntries)
            }
            .navigationTitle("Maintenance Log")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showingAddEntry.toggle() } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddEntry) {
                AddEntryView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }

    private func deleteEntries(at offsets: IndexSet) {
        withAnimation {
            offsets.map { entries[$0] }.forEach { entry in
                ReminderScheduler.shared.cancelReminder(for: entry)
                viewContext.delete(entry)
            }
            do {
                try viewContext.save()
            } catch {
                print("Failed to delete entries:", error)
            }
        }
    }

}

private let itemFormatter: DateFormatter = {
    let f = DateFormatter()
    f.dateStyle = .short
    f.timeStyle = .none
    return f
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext,
                         PersistenceController.preview.container.viewContext)
    }
}
