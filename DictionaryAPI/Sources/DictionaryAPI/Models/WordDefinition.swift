//
//  WordDefinition.swift
//
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation

public struct WordDefinition: Decodable {
    public let word: String?
    public let meanings: [Meaning]?
}

public struct Meaning: Decodable {
    public let partOfSpeech: String?
    public let definitions: [Definition]?
}

public struct Definition: Decodable {
    public let definition: String?
    public let example: String?
    public let synonyms: [String]?
}
