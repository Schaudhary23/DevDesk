//
//  DevDeskApp.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import SwiftUI
import SwiftData

@main
struct DevDeskApp: App {
    var body: some Scene {
        WindowGroup(id: "Repositories") {
            RootView()
        }
        .modelContainer(for: RepositoryEntity.self)
        .windowToolbarStyle(.unified)
        .commands {
            DevDeskCommands()
        }
    }
}
