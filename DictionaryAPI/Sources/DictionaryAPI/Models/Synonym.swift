//
//  Synonym.swift
//
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation

// MARK: - Synonym
/// Structure representing a synonym for a word.
public struct Synonym: Decodable {
    public let word: String?
    public let score: Int?
}
