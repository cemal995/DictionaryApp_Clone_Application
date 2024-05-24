//
//  APIEndpoints.swift
//
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation


// MARK: - APIEndpoints
/// A struct containing static methods to generate API endpoints.
public struct APIEndpoints {
    
    public static func wordDefinitionURL(for word: String) -> URL? {
        return URL(string:  "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)")
    }
    
    public static func synonymsURL(for word: String) -> URL? {
        return URL(string: "https://api.datamuse.com/words?rel_syn=\(word)")
    }
    
}
