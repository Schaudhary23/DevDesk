//
//  RepositoryDetailView.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(repository.name)
                .font(.largeTitle)
            
            Text(repository.description ?? "No description")
                .foregroundStyle(.secondary)
            
            HStack {
                Text("⭐️ \(repository.stars)")
                Text(repository.language ?? "Unknown")
            }
        }
        .padding()
    }
}

#Preview {
    RepositoryDetailView(repository: Repository(id: 1, name: "Name", description: "Description", language: "language", stars: 4))
}
