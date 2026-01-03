//
//  RepositoryListView.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositoryListViewModel
    @Environment(\.modelContext)
        private var modelContext
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.repositories) { repo in
                    NavigationLink(repo.name) {
                        RepositoryDetailView(repository: repo)
                            .environmentObject(viewModel)
                    }
                }
            }
            .listStyle(.sidebar)
        }
        .onAppear(perform: {
            viewModel.updateModelContext(modelContext)
        })
        
        if viewModel.isLoading {
            ProgressView()
        }
    }
}

#Preview {
    RepositoryListView(viewModel: RepositoryListViewModel(apiclient: APIClient(session: URLSession.shared)))
}
