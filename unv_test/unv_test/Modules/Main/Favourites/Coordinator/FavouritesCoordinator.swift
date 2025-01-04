//
//  SecondTabCoordinator.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit

final class FavouritesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let navigationController = UINavigationController()

    func start() {
        navigationController.isNavigationBarHidden = true
        let viewModel = FavouritesViewModel()
        let secondTabVC = FavouritesViewController()
        navigationController.setViewControllers([secondTabVC], animated: false)
    }
}
