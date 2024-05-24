//
//  SynonymCell.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 23.05.2024.
//

import UIKit
import DictionaryAPI


class SynonymCell: UITableViewCell {
    
    @IBOutlet weak var synonymLabelOne: UILabel!
    @IBOutlet weak var synonymLabelTwo: UILabel!
    @IBOutlet weak var synonymLabelThree: UILabel!
    @IBOutlet weak var synonymLabelFour: UILabel!
    @IBOutlet weak var synonymLabelFive: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with synonyms: [Synonym]) {
        
        let labels = [synonymLabelOne, synonymLabelTwo, synonymLabelThree, synonymLabelFour, synonymLabelFive]
        
        for label in labels {
            if let label = label {
                label.layer.borderWidth = 2.0
                label.layer.borderColor = UIColor.black.cgColor
                label.layer.cornerRadius = 10.0
                label.clipsToBounds = true
            }
        }
        
        for (index, label) in labels.enumerated() {
            if let label = label {
                if index < synonyms.count {
                    label.text = synonyms[index].word
                } else {
                    label.text = nil
                }
            }
        }
    }
}
