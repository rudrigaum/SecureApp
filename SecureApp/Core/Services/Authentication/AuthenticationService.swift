//
//  AuthenticationService.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 11/11/25.
//

import Foundation

final class AuthenticationService: AuthenticationServiceProtocol {
    
    private var isUserLoggedInState: Bool = false
    
    func login(user: String, password: String) -> Bool {
        if user == "admin" && password == "1234" {
            print("✅ AuthenticationService: Login Succeeded (Mock)")
            self.isUserLoggedInState = true
            return true
        } else {
            print("❌ AuthenticationService: Login Failed (Mock)")
            self.isUserLoggedInState = false
            return false
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return isUserLoggedInState
    }
}
