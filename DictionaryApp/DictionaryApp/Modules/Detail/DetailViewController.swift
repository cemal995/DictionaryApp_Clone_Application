//
//  DetailViewController.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 18.05.2024.
//

import UIKit
import DictionaryAPI

protocol DetailViewControllerProtocol: AnyObject {
    
}

final class DetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var wordPhoneticLabel: UILabel!
    @IBOutlet weak var wordNameLabel: UILabel!
    
    var wordDetails: [WordDefinition]?
    var partsOfSpeech: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabels()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: DetailViewCell.self)
    }
    
    private func configureLabels() {
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
    
}

extension DetailViewController: DetailViewControllerProtocol {
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let wordDetails = wordDetails else {
            return 0
        }
        
        return wordDetails.reduce(0) { count, wordDefinition in
            if let meanings = wordDefinition.meanings {
                return count + meanings.reduce(0) { $0 + ($1.definitions?.count ?? 0) }
            }
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeCell(cellType: DetailViewCell.self, indexPath: indexPath)
        
        guard let wordDetails = wordDetails else {
            return cell
        }
        
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


