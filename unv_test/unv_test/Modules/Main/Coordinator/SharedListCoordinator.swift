//
//  SharedListCoordinator.swift
//  unv_test
//
//  Created by Alex Oliynyk on 06.01.2025.
//

import UIKit

final class SharedListCoordinator: Coordinator {
    
    let state: ListScreenState
    
    var childCoordinators = [Coordinator]()
    
    let navigationController = UINavigationController()
    
    let viewModel: SharedListViewModel

    init(state: ListScreenState, viewModel: SharedListViewModel) {
        self.state = state
        self.viewModel = viewModel
    }

    func start() {
        let viewController = SharedListViewController(viewModel: viewModel, state: state)
        navigationController.isNavigationBarHidden = true
        navigationController.setViewControllers([viewController], animated: false)
    }
}
