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
        List(
            viewModel.repositories,
            selection: $viewModel.selectedRepository
        ) { repo in
            RepositoryRowView(repository: repo)
                .tag(repo)
        }
        .listStyle(.sidebar)
    }
}

#Preview {
    RepositoryListView(viewModel: RepositoryListViewModel(apiclient: APIClient(session: URLSession.shared)))
}
