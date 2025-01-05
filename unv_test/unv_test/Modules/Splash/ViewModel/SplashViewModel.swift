//
//  SplashViewModel.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import RxSwift

final class SplashViewModel {

    let isLoadingFinished = PublishSubject<Void>()

    let isLoading = BehaviorSubject<Bool>(value: false)

    private let disposeBag = DisposeBag()

    func loadData() {
        isLoading.onNext(true)
        Observable.just(())
            .delay(.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.isLoading.onNext(false)
                self?.isLoadingFinished.onCompleted()
            })
            .disposed(by: disposeBag)
    }
}
