//
//  AppCoordinator.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
   
    var childCoordinators = [Coordinator]()
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let splashCoordinator = SplashCoordinator(navigationController: navigationController)
        childCoordinators.append(splashCoordinator)
        splashCoordinator.start()

        splashCoordinator.onFinish = { [weak self, weak splashCoordinator] in
            guard let self = self, let splashCoordinator = splashCoordinator else { return }
            self.childCoordinators.removeAll { $0 === splashCoordinator }
            self.showMainFlow()
        }
    }

    private func showMainFlow() {
        let mainCoordinator = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
}
