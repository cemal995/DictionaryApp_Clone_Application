//
//  DetailPresenter.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation
import DictionaryAPI

protocol DetailPresenterProtocol: AnyObject {
    func playAudioButtonTapped()
}

final class DetailPresenter {
    
    var wordDetails: [WordDefinition]?
    
    unowned var view: DetailViewControllerProtocol!
    var interactor: DetailInteractorProtocol
    var router: DetailRouterProtocol
    
    init(view: DetailViewControllerProtocol, interactor: DetailInteractorProtocol, router: DetailRouterProtocol, wordDetails: [WordDefinition]) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.wordDetails = wordDetails
    }
    
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func playAudioButtonTapped() {
        guard let audioURLString = wordDetails?.first?.phonetics?.first?.audio,
              let audioURL = URL(string: audioURLString) else {
            view.showError("Audio is not avaliable for this word, please try a different word!")
            return
        }
        view.playAudio(from: audioURL)
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    
}
