//
//  LoginViewModel.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 11/11/25.
//

import Foundation

final class LoginViewModel {
    
    // MARK: - Dependencies
    private let authenticationService: AuthenticationServiceProtocol
    
    // MARK: - Coordinator Callbacks
    var onLoginSuccess: (() -> Void)?
    
    // MARK: - View Bindings (Outputs)
    var didUpdateLoadingState: ((Bool) -> Void)?
    var didReceiveError: ((String) -> Void)?
    
    // MARK: - View Properties (Inputs)
    var username: String = ""
    var password: String = ""
    
    // MARK: - Initializer
    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
    
    // MARK: - Public Methods (View Inputs)
    func didTapLoginButton() {
        if !isInputValid() {
            DispatchQueue.main.async { [weak self] in
                self?.didReceiveError?("Username and password cannot be empty.")
            }
            return
        }
    
        DispatchQueue.main.async { [weak self] in
            self?.didUpdateLoadingState?(true)
        }
        
        let success = authenticationService.login(
            user: username,
            password: password
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.didUpdateLoadingState?(false)
            
            if success {
                self?.onLoginSuccess?()
            } else {
                self?.didReceiveError?("Invalid username or password.")
            }
        }
    }
    
    // MARK: - Private Helpers
    private func isInputValid() -> Bool {
        let validUsername = !username.trimmingCharacters(in: .whitespaces).isEmpty
        let validPassword = !password.trimmingCharacters(in: .whitespaces).isEmpty
        return validUsername && validPassword
    }
}
