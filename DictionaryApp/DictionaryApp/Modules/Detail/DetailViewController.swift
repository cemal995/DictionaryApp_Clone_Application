//
//  DetailViewController.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 18.05.2024.
//

import UIKit
import Foundation
import DictionaryAPI
import AVFoundation

protocol DetailViewControllerProtocol: AnyObject {
    func setupTableView()
    func configureLabels()
    func playAudio(from url: URL)
    func showError(_ message: String)
}

final class DetailViewController: BaseViewController {
    
    var presenter: DetailPresenterProtocol!
    var audioPlayer: AVPlayer?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var wordPhoneticLabel: UILabel!
    @IBOutlet weak var wordNameLabel: UILabel!
    
    
    var wordDetails: [WordDefinition]?
    var wordSynonyms: [Synonym]?
    var partsOfSpeech: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabels()
        setupTableView()
    }
    
    @IBAction func audioButton(_ sender: UIButton) {
        presenter.playAudioButtonTapped()
    }
    
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func playAudio(from url: URL) {
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: DetailViewCell.self)
        tableView.register(cellType: SynonymCell.self)
    }
    
    func configureLabels() {
        guard let wordDefinition = wordDetails?.first else {
            return
        }
        
        if let word = wordDefinition.word {
            wordNameLabel.text = word.prefix(1).uppercased() + word.dropFirst()
        } else {
            wordNameLabel.text = nil
        }
        wordPhoneticLabel.text = wordDefinition.phonetic ?? "Phonetic Not Available"
    }
    
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let wordDetails = wordDetails else {
            return 0
        }
        
        let definitionCount = wordDetails.reduce(0) { count, wordDefinition in
            if let meanings = wordDefinition.meanings {
                return count + meanings.reduce(0) { $0 + ($1.definitions?.count ?? 0) }
            }
            return count
        }
        
        return definitionCount + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let wordDetails = wordDetails else {
            return UITableViewCell()
        }
        
        let definitionCount = wordDetails.reduce(0) { count, wordDefinition in
            if let meanings = wordDefinition.meanings {
                return count + meanings.reduce(0) { $0 + ($1.definitions?.count ?? 0) }
            }
            return count
        }
        
        if indexPath.row == definitionCount {
            
            let cell = tableView.dequeCell(cellType: SynonymCell.self, indexPath: indexPath)
            if let synonyms = wordSynonyms {
                cell.configure(with: synonyms)
            }
            return cell
        } else {
            
            let cell = tableView.dequeCell(cellType: DetailViewCell.self, indexPath: indexPath)
            
            var currentDefinitionIndex = 0
            for wordDefinition in wordDetails {
                if let meanings = wordDefinition.meanings {
                    for meaning in meanings {
                        if let definitions = meaning.definitions {
                            for definition in definitions {
                                if currentDefinitionIndex == indexPath.row {
                                    cell.configure(with: definition, partOfSpeech: meaning.partOfSpeech ?? "")
                                    return cell
                                }
                                currentDefinitionIndex += 1
                            }
                        }
                    }
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}



