//
//  InitialCoordinator.swift
//  Flag Challenge
//
//  Created by Anatoliy Ostapenko on 30.01.2025.
//

import UIKit
import SwiftUI

protocol InitialCoordinatorProtocol: Coordinator {
    func startGame()
}

class InitialCoordinator: InitialCoordinatorProtocol {
    private let navController: UINavigationController
    private let viewModel: InitialViewModel
    
    init(navController: UINavigationController, viewModel: InitialViewModel) {
        self.navController = navController
        self.viewModel = viewModel
    }
    
    func start() {        
        let initialVC = InitialViewController(viewModel: viewModel)
        initialVC.coordinator = self
        navController.setViewControllers([initialVC], animated: true)
    }

    func startGame() {
        let stepView = UIHostingController(rootView: StepView(viewModel: viewModel))
        viewModel.resetGame()
        viewModel.onGameFinished = { [weak self] in
            self?.navController.popViewController(animated: true)
        }
        navController.pushViewController(stepView, animated: true)
    }
}

