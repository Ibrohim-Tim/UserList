//
//  UserListViewController.swift
//  UserList
//
//  Created by Ibrahim Timurkaev on 29.02.2024.
//

import UIKit

final class UserListViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private var isSearching: Bool = false
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 80
        return tableView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        return activityIndicator
    }()
    
    private let networkService = UserListNetworkService()
    private var allUsers: [User] = []
    private var filteredUsers: [User] = []
    
    // MARK: - lifecycle
    
    override func loadView() {
        super.loadView()
            
        activityIndicator.startAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Users"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserListTableViewCell.self, forCellReuseIdentifier: UserListTableViewCell.reuseID)
        
        setupSearchController()
        setupTableViewLayout()
        setupActivityIndicatorLayout()
        
        fetchUsers()
    }
    
    //  MARK: - Private methods
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
        searchController.addObserver(self, forKeyPath: "isActive", options: .new, context: nil)
    }
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupActivityIndicatorLayout() {
        tableView.addSubview(activityIndicator)

        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }
    
    private func fetchUsers() {
        networkService.fetchUsers { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.allUsers = users
                self.filteredUsers = users
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.tableView.isUserInteractionEnabled = true
                }
            case .failure(let error):
                print("Failed to fetch users:", error)
            }
        }
    }
}

//  MARK: - UITableViewDataSource

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.reuseID, for: indexPath) as? UserListTableViewCell else {
            fatalError("Can not dequeue UserListTableViewCell")
        }
        
        let user = filteredUsers[indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.usernameLabel.text = user.username
        cell.emailLabel.text = user.email
        
        cell.configure(with: user)
        cell.selectionStyle = .none

        return cell
    }
}

// MARK: - UITableViewDelegate

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = filteredUsers[indexPath.row]
        let vc = UserInfoViewController(userItem: user)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UISearchBarDelegate

extension UserListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            // Если строка поиска пуста, отключаем поиск и показываем всех пользователей
            isSearching = false
            tableView.reloadData()
            return
        }
        
        // Фильтруем пользователей по тексту поиска
        filteredUsers = allUsers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        // Показываем отфильтрованный список пользователей
        isSearching = true
        tableView.reloadData()
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Скрываем таблицу при начале редактирования строки поиска
        tableView.isHidden = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Если текст в строке поиска пустой, скрываем таблицу
        if searchText.isEmpty {
            tableView.isHidden = true
            return
        }
        
        // Фильтруем пользователей по тексту поиска
        filteredUsers = allUsers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        // Показываем отфильтрованный список пользователей
        tableView.isHidden = false
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Показываем таблицу и сбрасываем фильтрацию при отмене поиска
        filteredUsers = allUsers
        tableView.isHidden = false
        tableView.reloadData()
    }
}
