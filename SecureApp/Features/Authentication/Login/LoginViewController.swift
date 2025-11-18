//
//  LoginViewController.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 11/11/25.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Dependencies
    private let viewModel: LoginViewModel
    private var loginView: LoginView!

    // MARK: - Initializer (Dependency Injection)
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(viewModel:) instead.")
    }

    // MARK: - View Lifecycle
    override func loadView() {
        loginView = LoginView()
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Secure Login"
        bindViewModel()
        bindViewActions()
    }
    
    // MARK: - Bindings
    private func bindViewModel() {
        viewModel.didUpdateLoadingState = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.loginView.updateLoading(isLoading: isLoading)
            }
        }
        
        viewModel.didReceiveError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showError(errorMessage)
            }
        }
    }
    
    private func bindViewActions() {
        loginView.loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        
        loginView.usernameTextField.addTarget(
            self,
            action: #selector(usernameDidChange),
            for: .editingChanged
        )
        
        loginView.passwordTextField.addTarget(
            self,
            action: #selector(passwordDidChange),
            for: .editingChanged
        )
    }
    
    // MARK: - UI Actions (View -> ViewModel)
    @objc private func loginButtonTapped() {
        viewModel.didTapLoginButton()
    }
    
    @objc private func usernameDidChange(_ textField: UITextField) {
        viewModel.username = textField.text ?? ""
    }
    
    @objc private func passwordDidChange(_ textField: UITextField) {
        viewModel.password = textField.text ?? ""
    }

    // MARK: - Private Helpers (UI Logic)
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
