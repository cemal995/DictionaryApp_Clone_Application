//
//  UITableView.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 20.05.2024.
//

import UIKit

// MARK: - UITableView Extension

extension UITableView {
    
    func register(cellType: UITableViewCell.Type) {
           register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
       }
    
    func dequeCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(cellType.identifier)")
        }
        return cell
    }
}


