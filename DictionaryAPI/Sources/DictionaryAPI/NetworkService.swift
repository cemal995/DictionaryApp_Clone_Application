//
//  NetworkService.swift
//
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation

public protocol NetworkService {
    func fetchWordDefinition(for word: String, completion: @escaping (Result<[WordDefinition], NetworkError>) -> Void)
    func fetchSynonyms(for word: String, completion: @escaping (Result<[Synonym], NetworkError>) -> Void)
}

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to decode the data."
        case .serverError(let statusCode):
            return "Server returned an error with status code \(statusCode)."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}

