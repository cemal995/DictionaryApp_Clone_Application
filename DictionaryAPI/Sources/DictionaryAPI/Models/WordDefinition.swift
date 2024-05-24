//
//  WordDefinition.swift
//
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation

// MARK: - WordDefinition
/// Structure representing a word definition.
public struct WordDefinition: Decodable {
    public let word: String?
    public let phonetic: String? 
    public let meanings: [Meaning]?
    public let phonetics: [Phonetic]?
}

public struct Meaning: Decodable {
    public let partOfSpeech: String?
    public let definitions: [Definition]?
}

public struct Phonetic: Decodable {
    public let audio: String?
}

public struct Definition: Decodable {
    public let definition: String?
    public let example: String?
    public let synonyms: [String]?
}
