//
//  RepositoryListViewModel.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation

@MainActor
final class RepositoryListViewModel: ObservableObject{
    @Published var repositories: [Repository] = []
    @Published var selectedRepository: Repository?
    
    init() {
        loadMockData()
    }
    
    func loadMockData() {
        repositories = [
            Repository(
                id: 1,
                name: "SwiftUI-Mac",
                description: "A macOS SwiftUI example app",
                language: "Swift",
                stars: 1200
            ),
            Repository(
                id: 2,
                name: "NetworkingKit",
                description: "Clean async/await networking",
                language: "Swift",
                stars: 800
            )
        ]
        selectedRepository = repositories.first
    }
    
}
