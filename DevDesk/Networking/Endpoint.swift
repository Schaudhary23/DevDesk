//
//  Endpoint.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

struct APIEnvironment {
    let scheme: String
    let host: String

    static let github = APIEnvironment(
        scheme: "https",
        host: "api.github.com"
    )
    static let testEnv = APIEnvironment(
        scheme: "https",
        host: "test/qa"
    )
}
