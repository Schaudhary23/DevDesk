//
//  RepositoryListViewModel.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation
import SwiftData

@MainActor
final class RepositoryListViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var selectedRepository: Repository?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiclient: APIClientProtocol
    private var modelContext: ModelContext?
    
    init(apiclient: APIClientProtocol = APIClient()) {
        self.apiclient = apiclient
    }
    func updateModelContext(_ context: ModelContext) {
        self.modelContext = context
        loadCachedRepositories()
        loadRepositories()
    }
    
    func loadCachedRepositories() {
        guard let modelContext else { return }
        let fetchDescriptor = FetchDescriptor<RepositoryEntity>()
        do {
            let entities = try modelContext.fetch(fetchDescriptor)
            NSLog("Entities fetched from local")
            repositories = entities.map({ repo in
                Repository(id: repo.id, name: repo.name, description: repo.repoDescription, language: repo.language, stars: repo.stars)
            })
            selectedRepository = repositories.first
        } catch {
            NSLog("❌ SwiftData fetch error: \(error)")
        }
    }
    
    func loadRepositories() {
        Task {
            guard let modelContext else { return }
            isLoading = true
            errorMessage = nil
            let endpoint = Endpoint(path: "/users/apple/repos", queryItems: nil)
            do {
                let repoData: [GitHubRepositoryDTO] = try await apiclient.fetch(endpoint: endpoint)
                let repos = repoData.map { $0.toDomain()}
                try modelContext.delete(model: RepositoryEntity.self)
                for repo in repos {
                    modelContext.insert(RepositoryEntity(from: repo))
                }
                repositories = repos
                selectedRepository = repos.first
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
    
}
