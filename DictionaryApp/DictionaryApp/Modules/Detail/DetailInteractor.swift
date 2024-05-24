//
//  DetailInteractor.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation

/// Protocol for the Detail Interactor.
protocol DetailInteractorProtocol: AnyObject {
    
}

/// Protocol for the output of the Detail Interactor.
protocol DetailInteractorOutputProtocol: AnyObject {
    
}

/// Interactor responsible for handling business logic within the Detail module.
final class DetailInteractor {
    /// Reference to the output delegate.
    weak var output: DetailInteractorOutputProtocol?
    
}

// MARK: - DetailInteractorProtocol Methods
extension DetailInteractor: DetailInteractorProtocol {
    
}
