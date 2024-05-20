//
//  SearchInteractor.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation

protocol SearchInteractorProtocol: AnyObject {
    func addSearchQuery(_ query: String)
    func removeSearchQuery(at index: Int)
    func fetchRecentSearches() -> [String]
    func saveRecentSearches(_ searches: [String])
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func didUpdateRecentSearches()
    func didFailWithError(_ error: Error)
}

final class SearchInteractor {
    
    weak var output: SearchInteractorOutputProtocol?
    
    private var searchModel = SearchModel()
    
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
        output?.didUpdateRecentSearches()
    }
    
    func removeSearchQuery(at index: Int) {
        guard index >= 0 && index < searchModel.recentSearches.count else {
            return
        }
        searchModel.recentSearches.remove(at: index)
        saveRecentSearches(searchModel.recentSearches)
        output?.didUpdateRecentSearches()
    }
    
    func fetchRecentSearches() -> [String] {
        return searchModel.recentSearches
    }
    
    func saveRecentSearches(_ searches: [String]) {
        defaults.set(searches, forKey: "RecentSearches")
    }
}


