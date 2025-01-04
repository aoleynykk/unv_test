//
//  TabBarCoordinator.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit
import RxRelay

class FavoritesManager {
    let favoritesRelay = BehaviorRelay<[ListCellModel]>(value: [])
}

final class TabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private let navigationController: UINavigationController
    private var tabBarController: UITabBarController?
    private let favoritesManager: FavoritesManager

    init(navigationController: UINavigationController, favoritesManager: FavoritesManager) {
        self.navigationController = navigationController
        self.favoritesManager = favoritesManager
    }

    func start() {
        navigationController.isNavigationBarHidden = true
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        self.tabBarController = tabBarController

        let firstTabCoordinator = ListCoordinator(favoritesManager: favoritesManager)
        let secondTabCoordinator = FavouritesCoordinator()//favoritesManager: favoritesManager)

        childCoordinators.append(firstTabCoordinator)
        childCoordinators.append(secondTabCoordinator)

        firstTabCoordinator.start()
        secondTabCoordinator.start()

        tabBarController.viewControllers = [
            firstTabCoordinator.navigationController,
            secondTabCoordinator.navigationController
        ]

        tabBarController.viewControllers?[0].tabBarItem = UITabBarItem(
            title: "List",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet")
        )

        tabBarController.viewControllers?[1].tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )

        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
