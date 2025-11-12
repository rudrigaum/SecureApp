//
//  AuthenticationCoordinatorDelegate.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 07/11/25.
//

import Foundation

protocol AuthenticationCoordinatorDelegate: AnyObject {
    func didFinishAuthentication(coordinator: Coordinator)
}
