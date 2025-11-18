//
//  MainCoordinatorDelegate.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 18/11/25.
//

import Foundation

protocol MainCoordinatorDelegate: AnyObject {
    func didRequestSignOut(coordinator: Coordinator)
}
