//
//  MainCoordinator.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 18/11/25.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var delegate: MainCoordinatorDelegate?
    private let tabBarController: UITabBarController
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    // MARK: - Coordinator Lifecycle
    func start() {
        setupTabs()
        navigationController.setViewControllers([tabBarController], animated: true)
        print("MainCoordinator: Main flow started with TabBarController.")
    }
    
    // MARK: - Tab Configuration
    private func setupTabs() {
        let homeVC = UIViewController()
        homeVC.view.backgroundColor = .systemBackground
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let transactionsVC = UIViewController()
        transactionsVC.view.backgroundColor = .systemBackground
        transactionsVC.title = "Transactions"
        transactionsVC.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(systemName: "creditcard"), tag: 1)
        
        let transactionsNav = UINavigationController(rootViewController: transactionsVC)
        
        let settingsVC = UIViewController()
        settingsVC.view.backgroundColor = .systemBackground
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOutTap))
        settingsVC.navigationItem.rightBarButtonItem = signOutButton
        
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        tabBarController.viewControllers = [homeNav, transactionsNav, settingsNav]
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.backgroundColor = .systemGroupedBackground
    }
    
    // MARK: - Actions
    @objc private func handleSignOutTap() {
        signOut()
    }
    
    func signOut() {
        childCoordinators.removeAll()
        delegate?.didRequestSignOut(coordinator: self)
    }
}
