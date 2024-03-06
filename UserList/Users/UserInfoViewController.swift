//
//  UserInfoViewController.swift
//  UserList
//
//  Created by Ibrahim Timurkaev on 04.03.2024.
//

import UIKit

final class UserInfoViewController: UIViewController {
    
    //  MARK: - UI Elements
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    //  MARK: - Init

    init(userItem: User) {
        super.init(nibName: nil, bundle: nil)
        
        hidesBottomBarWhenPushed = true
        
        nameLabel.text = userItem.name
        usernameLabel.text = userItem.username
        emailLabel.text = userItem.email
        phoneLabel.text = userItem.phone
        websiteLabel.text = userItem.website
        
        setup()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Private methods

    private func setup() {
        view.backgroundColor = .white
        
        setupNameLabelLayout()
        setupUsernameLabelLayout()
        setupEmailLabelLayout()
        setupPhoneLabelLayout()
        setupWebsiteLabelLayout()
    }
    
    private func setupNameLabelLayout() {
        view.addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupUsernameLabelLayout() {
        view.addSubview(usernameLabel)
        
        usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupEmailLabelLayout() {
        view.addSubview(emailLabel)
        
        emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 16).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupPhoneLabelLayout() {
        view.addSubview(phoneLabel)
        
        phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupWebsiteLabelLayout() {
        view.addSubview(websiteLabel)
        
        websiteLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 16).isActive = true
        websiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    func update(with userItem: User) {
        nameLabel.text = userItem.name
        usernameLabel.text = userItem.username
        emailLabel.text = userItem.email
        phoneLabel.text = userItem.phone
        websiteLabel.text = userItem.website
    }
}
