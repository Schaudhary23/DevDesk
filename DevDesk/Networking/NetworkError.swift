//
//  NetworkError.swift
//  DevDesk
//
//  Created by Shivam Chaudhary on 03/01/26.
//

import Foundation

enum NetworkError: LocalizedError {
    case inavlidURL
    case invalidResponse
    case decodingFailed
    case serverError(Int)
    
    var errorDescription: String? {
        switch self {
        case .inavlidURL:
            return "Inavild URL"
        case .invalidResponse:
            return "Invalid JSON Response"
        case .decodingFailed:
            return "Decodeing Failed"
        case .serverError(let code):
            return "Server error (code \(code))"
        }
    }
}
