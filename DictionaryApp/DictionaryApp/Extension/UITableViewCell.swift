//
//  UITableViewCell.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 20.05.2024.
//

import UIKit

// MARK: - UITableViewCell Extension

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
