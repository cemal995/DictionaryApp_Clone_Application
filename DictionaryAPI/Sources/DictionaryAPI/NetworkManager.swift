//
//  NetworkManager.swift
//
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation
import SystemConfiguration

public class NetworkManager: NetworkService {
    
    public static let shared = NetworkManager()
    private init() {}
    
    public func fetchWordDefinition(for word: String, completion: @escaping (Result<[WordDefinition], NetworkError>) -> Void) {
        
        guard let url = APIEndpoints.wordDefinitionURL(for: word) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let wordDefinitions = try JSONDecoder().decode([WordDefinition].self, from: data)
                completion(.success(wordDefinitions))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

    public func fetchSynonyms(for word: String, completion: @escaping (Result<[Synonym], NetworkError>) -> Void) {
        
        guard let url = APIEndpoints.synonymsURL(for: word) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let synonyms = try JSONDecoder().decode([Synonym].self, from: data)
                completion(.success(Array(synonyms.prefix(5))))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

extension NetworkManager {
    
    public func isConnectedToInternet() -> Bool {
        
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }) else {
                return false
            }
            
            var flags: SCNetworkReachabilityFlags = []
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                return false
            }
            
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            
            return isReachable && !needsConnection
        }
}
