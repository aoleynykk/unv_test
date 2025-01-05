//
//  TabBarCoordinator.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit
import RxRelay
import RxSwift

final class TabBarCoordinator: NSObject, Coordinator {

    var childCoordinators = [Coordinator]()

    private let navigationController: UINavigationController
   
    private var tabBarController: UITabBarController?

    private let sharedViewModel: SharedListViewModel

    init(navigationController: UINavigationController, sharedViewModel: SharedListViewModel = SharedListViewModel()) {
        self.navigationController = navigationController
        self.sharedViewModel = sharedViewModel
    }

    func start() {
        navigationController.isNavigationBarHidden = true

        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        self.tabBarController = tabBarController

        let listCoordinator = SharedListCoordinator(state: .allItems, viewModel: sharedViewModel)
        let favouritesCoordinator = SharedListCoordinator(state: .favourites, viewModel: sharedViewModel)

        childCoordinators = [listCoordinator, favouritesCoordinator]

        listCoordinator.start()
        favouritesCoordinator.start()

        setupTabBarItem(for: listCoordinator, title: "List", systemImageName: "list.bullet")
        setupTabBarItem(for: favouritesCoordinator, title: "Favourites", systemImageName: "star")

        tabBarController.viewControllers = [
            listCoordinator.navigationController,
            favouritesCoordinator.navigationController
        ]

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func setupTabBarItem(for coordinator: SharedListCoordinator, title: String, systemImageName: String) {
        let normalImage = UIImage(systemName: systemImageName)?.withTintColor(.theme(.gray), renderingMode: .alwaysOriginal)
        let selectedImage = UIImage(systemName: systemImageName + ".fill")?.withTintColor(.theme(.blue), renderingMode: .alwaysOriginal)

        coordinator.navigationController.tabBarItem = UITabBarItem(
            title: title,
            image: normalImage,
            selectedImage: selectedImage
        )
    }
}
