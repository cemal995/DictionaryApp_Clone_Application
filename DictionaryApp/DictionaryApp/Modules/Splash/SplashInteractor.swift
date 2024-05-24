//
//  SplashInteractor.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation
import DictionaryAPI

// MARK: - SplashInteractorProtocol
/// Protocol for the splash interactor.
protocol SplashInteractorProtocol: AnyObject {
    func checkInternetConnection()
}

// MARK: - SplashInteractorOutputProtocol
/// Protocol for handling output events from the splash interactor.
protocol SplashInteractorOutputProtocol: AnyObject {
    func internetConnection(status: Bool)
}

// MARK: - SplashInteractor
/// Interactor responsible for handling splash screen logic.
final class SplashInteractor {
    
    // MARK: - Properties
    weak var output: SplashInteractorOutputProtocol?
}

// MARK: - SplashInteractorProtocol
extension SplashInteractor: SplashInteractorProtocol {
    
    /// Checks the internet connection status.
    func checkInternetConnection() {
        let internetStatus = NetworkManager.shared.isConnectedToInternet()
        self.output?.internetConnection(status: internetStatus)
    }
}
