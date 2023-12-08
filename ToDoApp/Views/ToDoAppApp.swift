//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Владислав Лесовой on 07.12.2023.
//

import SwiftUI
import SwiftData

@main
struct ToDoAppApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Task.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TaskMainWindow()
        }
        .modelContainer(sharedModelContainer)
    }
}
