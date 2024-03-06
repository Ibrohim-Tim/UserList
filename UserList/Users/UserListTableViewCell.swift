//
//  UserListTableViewCell.swift
//  UserList
//
//  Created by Ibrahim Timurkaev on 29.02.2024.
//

import UIKit

final class UserListTableViewCell: UITableViewCell {
    
    //  MARK: - UI Elements
        
    static let reuseID = "UserListTableViewCell"
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        return usernameLabel
    }()
    
    let emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()
    
    //  MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
                
        setupUserNameLabelLayout()
        setupLoginLabelLayout()
        setupEmailLabelLayout()
    }

    //  MARK: - Private methods

    private func setupUserNameLabelLayout() {
        addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupLoginLabelLayout() {
        addSubview(usernameLabel)
        
        usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupEmailLabelLayout() {
        addSubview(emailLabel)
        
        emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
    
    func configure(with user: User) {
        nameLabel.text = user.name
        usernameLabel.text = user.username
        emailLabel.text = user.email
    }
}
