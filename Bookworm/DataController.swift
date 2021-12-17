//
//  DataController.swift
//  Bookworm
//
//  Created by Dayton Bobbitt on 12/16/21.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load persistent store: \(error.localizedDescription)")
            }
        }
    }
}
