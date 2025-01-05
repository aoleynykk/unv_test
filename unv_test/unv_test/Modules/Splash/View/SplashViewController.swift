//
//  SplashViewController.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit
import RxSwift

class SplashViewController: UIViewController {

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
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBindings()
    }

    private func setupBindings() {
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    ProgressHelper.show()
                } else {
                    ProgressHelper.hide()
                }
            })
            .disposed(by: disposeBag)

        viewModel.isLoadingFinished
            .observe(on: MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.handleLoadingFinished()
            })
            .disposed(by: disposeBag)
    }

    private func handleLoadingFinished() {
        print("Splash loading finished!!")
    }
}
