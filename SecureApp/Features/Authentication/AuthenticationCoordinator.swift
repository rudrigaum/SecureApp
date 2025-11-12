//
//  AuthenticationCoordinator.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 07/11/25.
//

import Foundation
import UIKit

final class AuthenticationCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var delegate: AuthenticationCoordinatorDelegate?
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator Lifecycle
    func start() {
        let authService = AuthenticationService()
        let viewModel = LoginViewModel(authenticationService: authService)
        let viewController = LoginViewController(viewModel: viewModel)
        
        viewModel.onLoginSuccess = { [weak self] in
            self?.finishAuthentication()
        }
        
        navigationController.setViewControllers([viewController], animated: true)
        print("AuthenticationCoordinator: Real LoginViewController presented.")
    }
    
    private func finishAuthentication() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.delegate?.didFinishAuthentication(coordinator: self)
        }
    }
}
