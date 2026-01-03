//
//  RepositoryRowView.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(repository.name)
                .font(.headline)
            
            if let language = repository.language {
                Text(language)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RepositoryRowView(repository: Repository(
        id: 1,
        name: "SwiftUI-Mac",
        description: "A macOS SwiftUI example app",
        language: "Swift",
        stars: 1200))
}
