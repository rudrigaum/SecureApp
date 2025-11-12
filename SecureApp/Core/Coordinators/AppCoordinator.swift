//
//  AppCoordinator.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 07/11/25.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let window: UIWindow
    
    // MARK: - Initializer
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    // MARK: - Coordinator Lifecycle
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showAuthenticationFlow()
    }
    
    // MARK: - Private Flow Methods
    private func showAuthenticationFlow() {
        let authCoordinator = AuthenticationCoordinator(navigationController: navigationController)
        authCoordinator.delegate = self
        addChild(authCoordinator)
        authCoordinator.start()
        print("AppCoordinator: Starting Authentication Flow via AuthenticationCoordinator.")
    }
    
    private func showMainFlow() {
        let placeholderVC = UIViewController()
        placeholderVC.view.backgroundColor = .systemGreen
        placeholderVC.title = "Main Flow (Placeholder)"
        navigationController.setViewControllers([placeholderVC], animated: true)
        print("AppCoordinator: Starting Main App Flow...")
    }
}

// MARK: - AuthenticationCoordinatorDelegate
extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didFinishAuthentication(coordinator: Coordinator) {
        removeChild(coordinator)
        print("AppCoordinator: Authentication finished. Starting Main Flow.")
        showMainFlow()
    }
}
