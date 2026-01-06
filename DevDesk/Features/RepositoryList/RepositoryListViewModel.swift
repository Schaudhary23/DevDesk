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
                Repository(
                    id: repo.id,
                    name: repo.name,
                    description: repo.repoDescription,
                    language: repo.language,
                    stars: repo.stars
                )
            })
            selectedRepository = repositories.first
            return
        } catch {
            debugPrint("❌ SwiftData fetch error: \(error)")
        }
    }
    
    func loadRepositories() {
        Task {
            loadCachedRepositories()
            guard let modelContext else { return }
            isLoading = true
            errorMessage = nil
            do {
                let dto: [GitHubRepositoryDTO] =
                try await apiclient.fetch(
                    endpoint: Endpoint(
                        path: "/users/apple/repos", queryItems: nil
                    )
                )
                let repos = dto.map { $0.toDomain()}
                let existing = try modelContext.fetch(
                    FetchDescriptor<RepositoryEntity>()
                )
                existing.forEach({modelContext.delete($0)})
                repos.forEach { modelContext.insert(RepositoryEntity(from: $0)) }
                repositories = repos
                selectedRepository = repos.first
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
    
    func refresh() {
        selectedRepository = nil
        loadRepositories()
    }
    
    func clearCache() {
        guard let modelContext = modelContext else { return }
        do {
            selectedRepository = nil
            repositories = []
            let entities = try modelContext.fetch(
                FetchDescriptor<RepositoryEntity>()
            )
            entities.forEach { modelContext.delete($0) }
        } catch {
            debugPrint("Error in clearCache() ----: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
}
