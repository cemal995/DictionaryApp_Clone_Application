//
//  SplashRouter.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation

// MARK: - SplashRoutes
/// Enumeration defining routes for the splash screen.
enum SplashRoutes {
    case searchScreen
}

// MARK: - SplashRouterProtocol
/// Protocol for the splash router.
protocol SplashRouterProtocol: AnyObject {
    func navigate(_ route: SplashRoutes)
}


// MARK: - SplashRouter
/// Router responsible for navigation from the splash screen.
final class SplashRouter {
    
    // MARK: - Properties
    weak var viewController: SplashViewController?
    
    // MARK: - Module Creation
    /// Creates and returns a new instance of the splash view controller.
    static func createModule() -> SplashViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

// MARK: - SplashRouterProtocol
extension SplashRouter: SplashRouterProtocol {
    
    /// Navigate to a specified route.
    func navigate(_ route: SplashRoutes) {
        switch route {
        case .searchScreen:
            let searchViewController = SearchRouter.createModule()
            viewController?.navigationController?.pushViewController(searchViewController, animated: true)
        }
    }
}
