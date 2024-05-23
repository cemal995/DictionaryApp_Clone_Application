//
//  DetailInteractor.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation

protocol DetailInteractorProtocol: AnyObject {
    
}

protocol DetailInteractorOutputProtocol: AnyObject {
    
}

final class DetailInteractor {
    
    weak var output: DetailInteractorOutputProtocol?
    
}

extension DetailInteractor: DetailInteractorProtocol {
    
}
