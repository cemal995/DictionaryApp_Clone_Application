//
//  SplashPresenter.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation

// MARK: - SplashPresenterProtocol
/// Protocol for the splash presenter.
protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

// MARK: - SplashPresenter
/// Presenter responsible for the splash screen logic.
final class SplashPresenter: SplashPresenterProtocol {
    
    // MARK: - Properties
    unowned var view: SplashViewControllerProtocol!
    var router: SplashRouterProtocol!
    var interactor: SplashInteractorProtocol!
    
    // MARK: - Initialization
    init(view: SplashViewControllerProtocol!, router: SplashRouterProtocol!, interactor: SplashInteractorProtocol!)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidAppear() {
        DispatchQueue.main.async {
            self.view.showLoadingView()
            self.interactor.checkInternetConnection()
        }
    }
}

// MARK: - SplashInteractorOutputProtocol
extension SplashPresenter: SplashInteractorOutputProtocol {
    
    /// Handles the internet connection status.
    func internetConnection(status: Bool) {
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.view.hideLoadingView()
                self.router.navigate(.searchScreen)
            }
        }
        else {
            view.noInternetConnection()
        }
    }
}
