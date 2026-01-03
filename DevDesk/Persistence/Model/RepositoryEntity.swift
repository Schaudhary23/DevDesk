//
//  RepositoryEntity.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import SwiftData

@Model
final class RepositoryEntity {
    @Attribute(.unique)
    var id: Int
    var name: String
    var repoDescription: String?
    var language: String?
    var stars: Int
    
    init(id: Int, name: String, repoDescription: String? = nil, language: String? = nil, stars: Int) {
        self.id = id
        self.name = name
        self.repoDescription = repoDescription
        self.language = language
        self.stars = stars
    }
}

extension RepositoryEntity {
    convenience init(from repo: Repository) {
        self.init(
            id: repo.id,
            name: repo.name,
            repoDescription: repo.description,
            language: repo.language,
            stars: repo.stars
            )
    }
}
