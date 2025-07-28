//
//  UserSession.swift
//  AutoLog
//
//  Created by Kero Nasr on 7/27/25.
//

import SwiftUI
import CoreData

final class UserSession: ObservableObject {
    @Published var currentUser: User!

    init(context: NSManagedObjectContext) {
        let req: NSFetchRequest<User> = User.fetchRequest()
        if let found = (try? context.fetch(req))?.first {
            currentUser = found
        } else {
            let u = User(context: context)
            u.id = UUID()
            u.name = "Me"
            try? context.save()
            currentUser = u
        }
    }
}
