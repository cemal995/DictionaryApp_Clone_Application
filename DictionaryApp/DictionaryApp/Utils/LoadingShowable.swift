//
//  LoadingShowable.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 20.05.2024.
//

import Foundation
import UIKit

// MARK: - LoadingShowable

protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    
    func showLoading() {
        
        LoadingView.startLoading()
    }
    
    func hideLoading() {
        
        LoadingView.shared.hideLoading()
        
    }
    
}
