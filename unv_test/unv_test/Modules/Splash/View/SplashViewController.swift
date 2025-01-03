//
//  SplashViewController.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit
import RxSwift

class SplashViewController: UIViewController {

    private let mainView = SplashView()
    private let viewModel: SplashViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.view = mainView
        bindViewModel()
        viewModel.loadData()
    }

    private func bindViewModel() {
        viewModel.isLoadingFinished
            .observe(on: MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.handleLoadingFinished()
            })
            .disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProgressHelper.show()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ProgressHelper.hide()
    }

    private func handleLoadingFinished() {
        print("Splash loading finished in controller")
    }
}
