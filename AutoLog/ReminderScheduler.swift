//
//  ReminderScheduler.swift
//  AutoLog
//
//  Created by Kero Nasr on 7/28/25.
//


import UserNotifications

final class ReminderScheduler {
  static let shared = ReminderScheduler()
  private let center = UNUserNotificationCenter.current()
  private init() { }

  func requestAuthorization() {
    center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
      if let err = error {
        print("Notification auth error:", err)
      }
    }
  }

  func scheduleReminder(for entry: MaintenanceEntry) {
    guard let date = entry.reminderDate else { return }

    let id = entry.notificationID ?? UUID().uuidString
    entry.notificationID = id

    let content = UNMutableNotificationContent()
    content.title = "Maintenance Reminder"
    content.body  = "Time for your \(entry.serviceType ?? "maintenance")!"
    content.sound = .default

    let triggerDate = Calendar.current.dateComponents([.year, .month, .day], from: date)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
    center.add(request) { error in
      if let err = error { print("Scheduling error:", err) }
    }
  }

  func cancelReminder(for entry: MaintenanceEntry) {
    if let id = entry.notificationID {
      center.removePendingNotificationRequests(withIdentifiers: [id])
      entry.notificationID = nil
    }
  }
}

