//
//  SearchViewController.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//


import UIKit

// MARK: - SearchViewControllerProtocol
/// Protocol for the search view controller.
protocol SearchViewControllerProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
}

// MARK: - SearchViewController
/// View controller responsible for displaying search functionality.
final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    var presenter: SearchPresenterProtocol!
    
    private var tableView: UITableView!
    private var searchButton: UIButton!
    private var searchBar: UISearchBar!
    
    private var searchButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupStandaloneSearchBar()
        setupSearchButton()
        registerForKeyboardNotifications()
        setupAccessibilityIdentifiers()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    deinit {
        unregisterForKeyboardNotifications()
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        
        navigationItem.title = "WordWiz"
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = UIColor.purple
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationBar.tintColor = UIColor.white
            navigationBar.isTranslucent = false
            navigationItem.hidesBackButton = true
        }
    }
    
    private func setupStandaloneSearchBar() {
        
        searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.delegate = self
        searchBar.accessibilityIdentifier = "SearchViewSearchBar"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.accessibilityIdentifier = "SearchViewTableView"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupSearchButton() {
        
        searchButton = UIButton(type: .system)
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.backgroundColor = .purple
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOpacity = 0.3
        searchButton.layer.shadowRadius = 2
        searchButton.accessibilityIdentifier = "SearchViewSearchButton"
        view.addSubview(searchButton)
        
        searchButtonBottomConstraint = searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchButtonBottomConstraint,
            searchButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - User Actions
    private func handleSearch() {
        
        view.endEditing(true)
        
        guard let query = searchBar.text, !query.isEmpty else {
            showError("Please enter a search query")
            return
        }
        presenter.addSearchQuery(query)
        presenter.fetchWordDetails(for: query)
    }
    
    private func setupAccessibilityIdentifiers() {
        
        searchBar.accessibilityIdentifier = "SearchViewSearchBar"
        searchButton.accessibilityIdentifier = "SearchViewSearchButton"
        tableView.accessibilityIdentifier = "SearchViewTableView"
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            searchButtonBottomConstraint.constant = -keyboardHeight - 16
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        
        searchButtonBottomConstraint.constant = -16
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func searchButtonTapped() {
        handleSearch()
    }
    
    
    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: view)
        if !searchButton.frame.contains(tapLocation) {
            view.endEditing(true)
        }
    }
    
}

// MARK: - SearchViewControllerProtocol
extension SearchViewController: SearchViewControllerProtocol {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRecentSearches()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let searchResult = presenter.recentSearch(at: indexPath.row)
        cell.textLabel?.text = searchResult
        cell.accessoryType = .none
        
        
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .gray
        cell.imageView?.image = icon.image
        
        let deleteButton = UIButton(type: .custom)
        deleteButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        deleteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        deleteButton.tag = indexPath.row
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        cell.accessoryView = deleteButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = presenter.recentSearch(at: indexPath.row)
        presenter.fetchWordDetails(for: selectedWord)
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        presenter.removeSearchQuery(at: sender.tag)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleSearch()
    }
}


