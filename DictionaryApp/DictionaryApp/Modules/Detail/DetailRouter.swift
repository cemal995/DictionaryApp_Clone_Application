//
//  DetailRouter.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation
import DictionaryAPI

// MARK: - DetailRouterProtocol
/// Protocol for the Detail Router.
protocol DetailRouterProtocol: AnyObject {
    
}

/// Router responsible for navigation from the Detail module.
final class DetailRouter {
    
    weak var viewController: DetailViewController?
    
    static func createModule(details: [WordDefinition], synonyms: [Synonym]) -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router, wordDetails: details)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

// MARK: - DetailRouterProtocol Extension
extension DetailRouter: DetailRouterProtocol {
    
}
