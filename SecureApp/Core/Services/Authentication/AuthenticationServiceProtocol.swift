//
//  AuthenticationServiceProtocol.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 11/11/25.
//

import Foundation

protocol AuthenticationServiceProtocol {
    func login(user: String, password: String) -> Bool
    func isUserLoggedIn() -> Bool
}
