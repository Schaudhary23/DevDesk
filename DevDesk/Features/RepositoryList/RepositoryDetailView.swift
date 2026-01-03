//
//  RepositoryDetailView.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository?
    var body: some View {
        Group {
                    if let repo = repository {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(repo.name)
                                .font(.largeTitle)

                            Text(repo.description ?? "No description")
                                .foregroundStyle(.secondary)

                            HStack {
                                Text("⭐️ \(repo.stars)")
                                Text(repo.language ?? "Unknown")
                            }
                        }
                        .padding()
                    } else {
                        Text("Select a repository")
                            .foregroundStyle(.secondary)
                    }
                }
    }
}

#Preview {
    RepositoryDetailView(repository: Repository(id: 1, name: "Name", description: "Description", language: "language", stars: 4))
}
