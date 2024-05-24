//
//  SearchInteractor.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation
import DictionaryAPI

// MARK: - SearchInteractorProtocol
/// Protocol for the search interactor.
protocol SearchInteractorProtocol: AnyObject {
    func addSearchQuery(_ query: String)
    func removeSearchQuery(at index: Int)
    func fetchRecentSearches() -> [String]
    func saveRecentSearches(_ searches: [String])
    func fetchWordDetails(for word: String)
}

// MARK: - SearchInteractorOutputProtocol
/// Protocol for the output of search interactor.
protocol SearchInteractorOutputProtocol: AnyObject {
    func didUpdateRecentSearches()
    func didFailWithError(_ error: Error)
    func didFetchWordDetails(definitions: [WordDefinition], synonyms: [Synonym])
}

// MARK: - SearchInteractor
/// Interactor responsible for search functionality.
final class SearchInteractor {
    
    weak var output: SearchInteractorOutputProtocol?
    
    private var searchModel = SearchModel()
    
    private let networkManager = NetworkManager.shared
    
    private let defaults = UserDefaults.standard
    
    init() {
        loadRecentSearches()
    }
    
    private func loadRecentSearches() {
        if let searches = defaults.stringArray(forKey: "RecentSearches") {
            searchModel.recentSearches = searches
        }
    }
}

// MARK: - SearchInteractorProtocol
extension SearchInteractor: SearchInteractorProtocol {
    
    func fetchWordDetails(for word: String) {
        
        var wordDefinitions: [WordDefinition]?
        var wordSynonyms: [Synonym]?
        
        let group = DispatchGroup()
        
        group.enter()
        networkManager.fetchWordDefinition(for: word) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let definitions):
                wordDefinitions = definitions
            case .failure(let error):
                self.output?.didFailWithError(error)
            }
            group.leave()
        }
        
        group.enter()
        networkManager.fetchSynonyms(for: word) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let synonyms):
                wordSynonyms = synonyms
            case .failure(let error):
                self.output?.didFailWithError(error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            if let wordDefinitions = wordDefinitions, let wordSynonyms = wordSynonyms {
                self.output?.didFetchWordDetails(definitions: wordDefinitions, synonyms: wordSynonyms)
            }
        }
    }
    
    func addSearchQuery(_ query: String) {
        if searchModel.recentSearches.contains(query) {
            return
        }
        if searchModel.recentSearches.count >= 5 {
            searchModel.recentSearches.removeFirst()
        }
        searchModel.recentSearches.append(query)
        saveRecentSearches(searchModel.recentSearches)
        DispatchQueue.main.async {
            self.output?.didUpdateRecentSearches()
        }
    }
    
    func removeSearchQuery(at index: Int) {
        guard index >= 0 && index < searchModel.recentSearches.count else {
            return
        }
        searchModel.recentSearches.remove(at: index)
        saveRecentSearches(searchModel.recentSearches)
        DispatchQueue.main.async {
            self.output?.didUpdateRecentSearches()
        }
    }
    
    func fetchRecentSearches() -> [String] {
        return searchModel.recentSearches
    }
    
    func saveRecentSearches(_ searches: [String]) {
        defaults.set(searches, forKey: "RecentSearches")
    }
}


