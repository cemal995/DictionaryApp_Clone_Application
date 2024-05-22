//
//  SearchInteractor.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation
import DictionaryAPI

protocol SearchInteractorProtocol: AnyObject {
    func addSearchQuery(_ query: String)
    func removeSearchQuery(at index: Int)
    func fetchRecentSearches() -> [String]
    func saveRecentSearches(_ searches: [String])
    func fetchWordDefinition(for word: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func didUpdateRecentSearches()
    func didFailWithError(_ error: Error)
    func didFetchWordDefinitions(_ definitions: [WordDefinition])
}

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

extension SearchInteractor: SearchInteractorProtocol {
    
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
    
    func fetchWordDefinition(for word: String) {
        networkManager.fetchWordDefinition(for: word) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let definitions):
                DispatchQueue.main.async {
                    self.output?.didFetchWordDefinitions(definitions)
                    // print(definitions)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.didFailWithError(error)
                }
            }
        }
    }
}


