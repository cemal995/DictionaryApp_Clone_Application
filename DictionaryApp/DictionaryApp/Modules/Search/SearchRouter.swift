//
//  SearchRouter.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation
import DictionaryAPI

protocol SearchRouterProtocol: AnyObject {
    func navigateToWordDetails(details: [WordDefinition],synonyms: [Synonym])
}

final class SearchRouter {
    
    weak var viewController: SearchViewController?
    
    static func createModule() -> SearchViewController{
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SearchRouter: SearchRouterProtocol {
    
    func navigateToWordDetails(details: [WordDefinition], synonyms: [Synonym]) {
        let detailViewController = DetailRouter.createModule(details: details, synonyms: synonyms)
        detailViewController.wordDetails = details
        detailViewController.wordSynonyms = synonyms
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
