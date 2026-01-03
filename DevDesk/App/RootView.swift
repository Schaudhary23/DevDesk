//
//  RootView.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 04/01/26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var viewModel = RepositoryListViewModel()
    
    var body: some View {
        NavigationSplitView {
            RepositoryListView(viewModel: viewModel)
                .navigationTitle("Repositories")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            viewModel.refresh()
                        } label: {
                            Label("Refresh", systemImage: "arrow.clockwise")
                        }
                        .disabled(viewModel.isLoading)
                    }
                }
        } detail: {
            if let repo = viewModel.selectedRepository {
                RepositoryDetailView(repository: repo)
            } else {
                Text("Select a Repository")
                    .foregroundStyle(.secondary)
                    .navigationTitle("Details")
            }
        }
        .navigationSplitViewColumnWidth(min: 180, ideal: 250)
        .focusedSceneObject(viewModel)
        .onAppear {
            viewModel.updateModelContext(modelContext)
        }
        
    }
}
