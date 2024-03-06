//
//  UserItem.swift
//  UserList
//
//  Created by Ibrahim Timurkaev on 04.03.2024.
//

import UIKit

struct User: Decodable, Equatable {
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    
    init(
        name: String,
        username: String,
        email: String,
        phone: String,
        website: String
    ) {
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
    }
}
