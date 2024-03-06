//
//  MainTabBarController.swift
//  UserList
//
//  Created by Ibrahim Timurkaev on 04.03.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Navigation
    
    private var userNavigationController: UINavigationController {
        let viewController = UserListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Users",
            image: UIImage(systemName: "list.bullet.clipboard"),
            selectedImage: UIImage(systemName: "list.bullet.clipboard.fill")
        )
        return navigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [userNavigationController]
    }
}
