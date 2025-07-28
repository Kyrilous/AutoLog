//
//  User+CoreDataProperties.swift
//  AutoLog
//
//  Created by Kero Nasr on 7/28/25.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var entries: MaintenanceEntry?

}

extension User : Identifiable {

}
