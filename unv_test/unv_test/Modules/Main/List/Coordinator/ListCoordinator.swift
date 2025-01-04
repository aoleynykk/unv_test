//
//  ListCoordinator.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit
import RxRelay

final class ListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let navigationController = UINavigationController()
    private let favoritesManager: FavoritesManager

    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
    }

    func start() {
        navigationController.isNavigationBarHidden = true
        let viewModel = ListViewModel(favourites: favoritesManager.favoritesRelay)
        let firstTabVC = ListViewController(viewModel: viewModel)
        navigationController.setViewControllers([firstTabVC], animated: false)
    }
}
