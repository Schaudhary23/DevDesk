//
//  RepositoryListViewModel.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation

@MainActor
final class RepositoryListViewModel: Observable, ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var selectedRepository: Repository?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiclient: APIClientProtocol
    
    init(apiclient: APIClientProtocol = APIClient()) {
        self.apiclient = apiclient
        loadRepositories()
    }
    
    func loadRepositories() {
        Task {
            isLoading = true
            errorMessage = nil
            let endpoint = Endpoint(path: "/users/apple/repos", queryItems: nil)
            do {
                let repoData: [GitHubRepositoryDTO] = try await apiclient.fetch(endpoint: endpoint)
                let repos = repoData.map { $0.toDomain()}
                repositories = repos
                selectedRepository = repos.first
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
        
        selectedRepository = repositories.first
    }
    
}
