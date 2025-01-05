//
//  SplashCoordinator.swift
//  unv_test
//
//  Created by Alex Olynyk on 03.01.2025.
//

import UIKit
import RxSwift

final class SplashCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()

    private let navigationController: UINavigationController
    
    private let disposeBag = DisposeBag()

    var onFinish: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = SplashViewModel()
        let splashViewController = SplashViewController(viewModel: viewModel)

        bindViewModel(viewModel)

        navigationController.setViewControllers([splashViewController], animated: false)
        viewModel.loadData()
    }

    private func bindViewModel(_ viewModel: SplashViewModel) {
        viewModel.isLoadingFinished
            .observe(on: MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.onFinish?()
            })
            .disposed(by: disposeBag)
    }
}
