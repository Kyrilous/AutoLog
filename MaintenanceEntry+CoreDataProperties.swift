//
//  MaintenanceEntry+CoreDataProperties.swift
//  AutoLog
//
//  Created by Kero Nasr on 7/28/25.
//
//

import Foundation
import CoreData


extension MaintenanceEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MaintenanceEntry> {
        return NSFetchRequest<MaintenanceEntry>(entityName: "MaintenanceEntry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var mileage: Int64
    @NSManaged public var serviceType: String?
    @NSManaged public var notes: String?
    @NSManaged public var reminderDate: Date?
    @NSManaged public var notificationID: String?
    @NSManaged public var owner: User?

}

extension MaintenanceEntry : Identifiable {

}
