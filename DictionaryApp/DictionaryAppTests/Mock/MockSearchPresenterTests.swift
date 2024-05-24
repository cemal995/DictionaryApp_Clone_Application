//
//  MockSearchPresenterTests.swift
//  DictionaryAppTests
//
//  Created by Cemalhan Alptekin on 24.05.2024.
//

import XCTest
@testable import DictionaryApp
@testable import DictionaryAPI
final class MockSearchPresenterTests: XCTestCase {
    
    var presenter: SearchPresenter!
    var view: MockSearchViewController!
    var interactor: MockSearchInteractor!
    var router: MockSearchRouter!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, interactor: interactor, router: router)
    }
    
    override func tearDown() {
        super.tearDown()
        
        view = nil
        interactor = nil
        router = nil
        presenter = nil
        
    }
    
    func test_viewDidLoad_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedSetupNavigationBar)
        XCTAssertFalse(view.isInvokedSetupSearchButton)
        XCTAssertFalse(view.isInvokedSetupStandaloneSearchBar)
    }

}

extension WordDefinition {
    
    static var response: WordDefinition {
        let bundle = Bundle(for: MockSearchPresenterTests.self)
        let path = bundle.path(forResource: "WordDefinition", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(WordDefinition.self,from: data)
        return response
    }
}

