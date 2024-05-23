//
//  DetailViewCell.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 21.05.2024.
//

import UIKit
import DictionaryAPI

class DetailViewCell: UITableViewCell {
    
    @IBOutlet weak var wordPartOfSpeechLabel: UILabel!
    @IBOutlet weak var wordDefinitionLabel: UILabel!
    @IBOutlet weak var wordExampleLabel: UILabel!
    @IBOutlet weak var wordExampleTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configure(with definition: Definition, partOfSpeech: String) {
        wordPartOfSpeechLabel.text = partOfSpeech.capitalized
        wordDefinitionLabel.text = definition.definition
        wordExampleLabel.text = definition.example != nil ? "Example" : ""
        wordExampleTextLabel.text = definition.example
    }
    
}


