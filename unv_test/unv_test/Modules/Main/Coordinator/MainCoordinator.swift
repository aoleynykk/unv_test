//
//  MainCoordinator.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewController = MainViewController()
        navigationController.setViewControllers([mainViewController], animated: true)
    }
}
