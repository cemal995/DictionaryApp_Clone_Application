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
    func fetchWordDefinition(for word: String)
}

final class SearchPresenter {
    
    unowned var view: SearchViewControllerProtocol
    var interactor: SearchInteractorProtocol
    var router: SearchRouterProtocol

    init(view: SearchViewControllerProtocol, interactor: SearchInteractorProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    
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
    
    func fetchWordDefinition(for word: String) {
        interactor.fetchWordDefinition(for: word) 
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
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
    
    func didFetchWordDefinitions(_ definitions: [WordDefinition]) {
        DispatchQueue.main.async {
            self.router.navigateToWordDetails(details: definitions)
            //print(definitions)
        }
    }
}
