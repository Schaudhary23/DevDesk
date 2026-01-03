//
//  GitHubRepositoryDTO.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation

struct GitHubRepositoryDTO: Decodable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let stargazers_count: Int
}

extension GitHubRepositoryDTO {
    func toDomain() -> Repository {
        return Repository(id: self.id, name: self.name, description: self.description, language: self.language, stars: self.stargazers_count)
    }
}
