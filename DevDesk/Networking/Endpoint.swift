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
    
    var url: URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.github.com"
        component.path = path
        component.queryItems = queryItems
        return component.url
    }
}

struct APIEnvironment {
    let scheme: String
    let host: String

    static let github = APIEnvironment(
        scheme: "https",
        host: "api.github.com"
    )
}
