//
//  BaseViewController.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import UIKit

// MARK: - BaseViewController
/// A base view controller providing common functionality.
class BaseViewController: UIViewController, LoadingShowable {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Alert Presentation
    /// Presents an alert with the given title and message.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message body of the alert.
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
