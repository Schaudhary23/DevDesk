//
//  RepositoryListView.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositoryListViewModel
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.repositories) { repo in
                    NavigationLink(repo.name) {
                        RepositoryDetailView(repository: repo)
                            .environment(viewModel)
                    }
                }
            }
            .listStyle(.sidebar)
        }
        
        if viewModel.isLoading {
            ProgressView()
        }
    }
}

#Preview {
    RepositoryListView(viewModel: RepositoryListViewModel(apiclient: APIClient(session: URLSession.shared)))
}
