//
//  MockSearchViewController.swift
//  DictionaryAppTests
//
//  Created by Cemalhan Alptekin on 24.05.2024.
//

import Foundation
@testable import DictionaryApp

final class MockSearchViewController: SearchViewControllerProtocol {
    
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        isInvokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    var isInvokedShowError = false
    var invokedShowErrorCount = 0
    
    func showError(_ message: String) {
        isInvokedShowError = true
        invokedShowErrorCount += 1
    }
    
    var isInvokedSetupNavigationBar = false
    var invokedSetupNavigationBarCount = 0
    
    func setupNavigationBar() {
        isInvokedSetupNavigationBar = true
        invokedSetupNavigationBarCount += 1
    }
    
    var isInvokedSetupStandaloneSearchBar = false
    var invokedSetupStandaloneSearchBarCount = 0
    
    func setupStandaloneSearchBar() {
        isInvokedSetupStandaloneSearchBar = true
        invokedSetupStandaloneSearchBarCount += 1
    }
    
    var isInvokedSetupSearchButton = false
    var invokedSetupSearchButtonCount = 0
    
    func setupSearchButton() {
        isInvokedSetupSearchButton = true
        invokedSetupSearchButtonCount += 1
    }
}
