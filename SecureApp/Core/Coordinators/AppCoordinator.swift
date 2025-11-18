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
    private let authService: AuthenticationServiceProtocol
    
    // MARK: - Initializer
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        self.authService = AuthenticationService()
    }
    
    // MARK: - Coordinator Lifecycle
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        if authService.isUserLoggedIn() {
            showMainFlow()
        } else {
            showAuthenticationFlow()
        }
    }
    
    // MARK: - Flow Handlers
    private func showAuthenticationFlow() {
        let authCoordinator = AuthenticationCoordinator(
            navigationController: navigationController,
            authService: authService
        )
        
        authCoordinator.delegate = self
        addChild(authCoordinator)
        authCoordinator.start()
        print("AppCoordinator: Starting Authentication Flow via Coordinator.")
    }
    
    private func showMainFlow() {
        let mainCoordinator = MainCoordinator(
            navigationController: navigationController
        )
        
        mainCoordinator.delegate = self
        addChild(mainCoordinator)
        mainCoordinator.start()
        print("AppCoordinator: Starting Main App Flow via MainCoordinator.")
    }
    
    // MARK: - Sign Out Management
    private func returnToAuthentication() {
        navigationController.viewControllers = []
        showAuthenticationFlow()
    }
}

// MARK: - Delegate Conformance
extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didFinishAuthentication(coordinator: Coordinator) {
        removeChild(coordinator)
        print("AppCoordinator: Authentication finished. Starting Main Flow.")
        showMainFlow()
    }
}

extension AppCoordinator: MainCoordinatorDelegate {
    func didRequestSignOut(coordinator: Coordinator) {
        removeChild(coordinator)
        returnToAuthentication()
        print("AppCoordinator: Sign out request received. Returning to Login.")
    }
}
