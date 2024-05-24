//
//  MockSearchInteractor.swift
//  DictionaryAppTests
//
//  Created by Cemalhan Alptekin on 24.05.2024.
//

import Foundation
@testable import DictionaryApp

final class MockSearchInteractor: SearchInteractorProtocol {
    
    var isInvokedAddSearchQuery = false
    var isInvokedAddSearchQueryCount = 0
    
    func addSearchQuery(_ query: String) {
        isInvokedAddSearchQuery = true
        isInvokedAddSearchQueryCount += 1
    }
    
    var isInvokedRemoveSearchQuery = false
    var isInvokedRemoveSearchQueryCount = 0
    
    func removeSearchQuery(at index: Int) {
        isInvokedRemoveSearchQuery = true
        isInvokedRemoveSearchQueryCount += 1
    }
    
    var isInvokedFetchRecentSearches = false
    var isInvokedFetchedRecentSearchesCount = 0
    var WordDefinition = [String]()
    
    func fetchRecentSearches() -> [String] {
        isInvokedFetchRecentSearches = true
        isInvokedSaveRecentSearchesCount += 1
        return WordDefinition
    }
    
    var isInvokedSaveRecentSearches = false
    var isInvokedSaveRecentSearchesCount = 0
    
    func saveRecentSearches(_ searches: [String]) {
        isInvokedSaveRecentSearches = true
        isInvokedSaveRecentSearchesCount += 1
    }
    
    var isInvokedFetchWordDetails = false
    var isInvokedFetchWordDetailsCount = 0
    
    func fetchWordDetails(for word: String) {
        isInvokedFetchWordDetails = true
        isInvokedFetchWordDetailsCount += 1
    }
    
    
}
