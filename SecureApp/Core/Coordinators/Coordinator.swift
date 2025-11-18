//
//  Coordinator.swift
//  SecureApp
//
//  Created by Rodrigo Cerqueira Reis on 06/11/25.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

// MARK: - Default Implementation for Child Management
extension Coordinator {
    
    func addChild(_ child: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === child }) else {
            return
        }
        childCoordinators.append(child)
    }

    func removeChild(_ child: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}
