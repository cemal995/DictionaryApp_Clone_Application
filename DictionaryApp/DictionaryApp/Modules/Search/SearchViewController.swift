//
//  SearchViewController.swift
//  DictionaryApp
//
//  Created by Cemalhan Alptekin on 17.05.2024.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
}

final class SearchViewController: BaseViewController {
    
    var presenter: SearchPresenterProtocol!
    
    private var tableView: UITableView!
    private var searchButton: UIButton!
    private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupStandaloneSearchBar()
        setupSearchButton()
    }
    
    private func setupNavigationBar() {
        
        navigationItem.title = "DictionaryDB"
        
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
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            searchButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func searchButtonTapped() {
        guard let query = searchBar.text, !query.isEmpty else {
            showError("Please enter a search query")
            return
        }
        presenter.addSearchQuery(query)
        presenter.fetchWordDetails(for: query)
    }
}

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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRecentSearches()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let searchResult = presenter.recentSearch(at: indexPath.row)
        cell.textLabel?.text = searchResult
        cell.accessoryType = .none
        
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

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else {
            showError("Please enter a search query")
            return
        }
        presenter.addSearchQuery(query)
    }
}


