//
//  APIClient.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T
}

final class APIClient: APIClientProtocol {
    private let session: URLSession
    private let environment: APIEnvironment
    
    init(session: URLSession = .shared,environment: APIEnvironment = .github) {
        self.session = session
        self.environment = environment
    }
    
    func fetch<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
        
        var components = URLComponents()
        components.scheme = environment.scheme
        components.host = environment.host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        
        guard let url = components.url else {
            throw NetworkError.inavlidURL
        }
        
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        
        
        let (data, response) = try await session.data(for: urlReq)
        print("Network call finished")
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            let data = try JSONDecoder().decode(T.self, from: data)
            return data
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
