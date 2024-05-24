//
//  SplashViewController.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import UIKit

// MARK: - SplashViewControllerProtocol
/// Protocol for handling splash view controller events.
protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
    func showLoadingView()
    func hideLoadingView()
}

// MARK: - SplashViewController
/// View controller for the splash screen.
final class SplashViewController: BaseViewController {
    
    // MARK: - Properties
    var presenter: SplashPresenterProtocol!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform initial setup
        DispatchQueue.main.async {
            self.presenter.viewDidAppear()
        }
    }
    
}

// MARK: - SplashViewControllerProtocol
extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
        showAlert(title: "No Internet Connection", message: "There is a problem with your internet connection, please check your connection")
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    
}

