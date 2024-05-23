//
//  SearchPresenter.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation
import DictionaryAPI

protocol SearchPresenterProtocol: AnyObject {
    func addSearchQuery(_ query: String)
    func removeSearchQuery(at index: Int)
    func numberOfRecentSearches() -> Int
    func recentSearch(at index: Int) -> String
    func fetchWordDetails(for word: String)
}

final class SearchPresenter {
    
    unowned var view: SearchViewControllerProtocol!
    var interactor: SearchInteractorProtocol!
    var router: SearchRouterProtocol!

    init(view: SearchViewControllerProtocol, interactor: SearchInteractorProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func fetchWordDetails(for word: String) {
        interactor.fetchWordDetails(for: word)
    }
    
    func addSearchQuery(_ query: String) {
        interactor.addSearchQuery(query)
    }
    
    func removeSearchQuery(at index: Int) {
        interactor.removeSearchQuery(at: index)
    }
    
    func numberOfRecentSearches() -> Int {
        return interactor.fetchRecentSearches().count
    }
    
    func recentSearch(at index: Int) -> String {
        return interactor.fetchRecentSearches()[index]
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
    func didFetchWordDetails(definitions: [WordDefinition], synonyms: [Synonym]) {
        DispatchQueue.main.async {
            self.router.navigateToWordDetails(details: definitions, synonyms: synonyms)
        }
    }
    
    func didUpdateRecentSearches() {
        DispatchQueue.main.async {
            self.view.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.view.showError(error.localizedDescription)
        }
    }
}
