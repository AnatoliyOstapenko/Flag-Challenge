//
//  AppCoordinator.swift
//  Flag Challenge
//
//  Created by Anatoliy Ostapenko on 30.01.2025.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navController = UINavigationController()
        let viewModel = InitialViewModel()
        let mainCoordinator = InitialCoordinator(
            navController: navController,
            viewModel: viewModel
        )
        mainCoordinator.start()
        childCoordinators = [mainCoordinator]
        window.rootViewController = navController
    }
}

