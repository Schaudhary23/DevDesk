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
    @StateObject private var viewModel = RepositoryListViewModel()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            NavigationSplitView {
                RepositoryListView(viewModel: viewModel)
            } detail: {
                Text("Please Select Repository")
            }

        }
        .modelContainer(sharedModelContainer)
    }
}
