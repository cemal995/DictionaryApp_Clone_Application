//
//  DictionaryAppUITests.swift
//  DictionaryAppUITests
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import XCTest

final class DictionaryAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("********** TEST STARTED **********")
    }
    
    func test_exists_element() {
        app.launch()
        sleep(3)
        XCTAssertTrue(app.isSearchViewTableViewDisplayed, "SearchView Table View does not exists")
        
        sleep(2)
        XCTAssertTrue(app.isSearchViewSearchButtonDisplayed, "SearchView Search Button does not exists")
        sleep(5)
        XCTAssertTrue(app.searchFields["Search"].exists, "SearchView Search Bar does not exists")
        
    }
    
    func test_click_SearchButton() {
        app.launch()
        app.SearchViewSearchButton.tap()
    }
    
    func test_navigate_to_detailview_from_tableView() {
        app.launch()
        sleep(3)
        XCTAssertTrue(app.isSearchViewTableViewDisplayed, "SearchView Table View does not exists")
        let firstCell = app.SearchViewTableView.cells.element(boundBy: 0)
        firstCell.tap()
        sleep(5)
        XCTAssertTrue(app.isDetailViewTableViewDisplayed, "DetailView Table View does not exists")
    }
    
    func test_audio_button_played() {
        app.launch()
        sleep(3)
        XCTAssertTrue(app.isSearchViewTableViewDisplayed, "SearchView Table View does not exists")
        app/*@START_MENU_TOKEN@*/.searchFields["Search"]/*[[".otherElements[\"SearchViewSearchBar\"].searchFields[\"Search\"]",".searchFields[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.searchFields["Search"].typeText("Drive")
        app.SearchViewSearchButton.tap()
        app.SearchViewSearchButton.tap()
        XCTAssertTrue(app.isAudioButtonDisplayed, "Audio Button does not exists")
        app.AudioButton.tap()
    }
    
    func test_searchbar_search() {
        app.launch()
        app/*@START_MENU_TOKEN@*/.searchFields["Search"]/*[[".otherElements[\"SearchViewSearchBar\"].searchFields[\"Search\"]",".searchFields[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.searchFields["Search"].typeText("Drive")
        app.SearchViewSearchButton.tap()
    }
    
    
}

extension XCUIApplication {
    
    var SearchViewSearchBar: XCUIElement! {
        searchFields["SearchViewSearchBar"]
    }
    
    var SearchViewSearchButton: XCUIElement! {
        buttons["SearchViewSearchButton"]
    }
    
    var SearchViewTableView: XCUIElement! {
        tables["SearchViewTableView"]
    }
    
    var DetailViewTableView: XCUIElement {
        tables["DetailViewTableView"]
    }
    
    var AudioButton: XCUIElement {
        buttons["AudioButton"]
    }
    
    var isSearchViewSearchBarDisplayed: Bool {
        SearchViewSearchBar.exists
    }
    
    var isSearchViewSearchButtonDisplayed: Bool {
        SearchViewSearchButton.exists
    }
    
    var isSearchViewTableViewDisplayed: Bool {
        SearchViewTableView.exists
    }
    
    var isDetailViewTableViewDisplayed: Bool {
        DetailViewTableView.exists
    }
    
    var isAudioButtonDisplayed: Bool {
        AudioButton.exists
    }
    
}
