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
        List {
            ForEach(viewModel.repositories) { repo in
                NavigationLink(repo.name) {
                    RepositoryDetailView(repository: repo)
                }
            }
        }
        .listStyle(.sidebar)
    }
}

#Preview {
    RepositoryListView(viewModel: RepositoryListViewModel())
}
