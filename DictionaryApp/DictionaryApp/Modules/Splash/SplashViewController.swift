//
//  SplashViewController.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import Foundation
import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
    func showLoadingView()
    func hideLoadingView()
}

final class SplashViewController: BaseViewController {
    
    var presenter: SplashPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.presenter.viewDidAppear()
        }
    }
    
}

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

