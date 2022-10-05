//
//  CenterListViewModel.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class CenterListViewModel {
    private let disposeBag = DisposeBag()

    @NetworkInjector(keypath: \.centersRepository)
    private var repository: CentersRepository

    let viewDidLoad = PublishRelay<Void>()
    let didLoadCenter = BehaviorRelay<[Center]>(value: [])
    let didScrollBottom = PublishRelay<Void>()

    init() {
        bind()
    }
}

// MARK: - Bind

private extension CenterListViewModel {
    func bind() {
        Observable.merge(viewDidLoad.asObservable(), didScrollBottom.asObservable())
            .withLatestFrom(didLoadCenter) { $1.count / 10 + 1 }
            .withUnretained(self)
            .flatMapLatest { viewModel, page in
                viewModel.repository.requestCenters(page: page)}
            .scan([Center](), accumulator: +)
            .map { $0.sorted { $0.updatedAt > $1.updatedAt } }
            .bind(to: didLoadCenter)
            .disposed(by: disposeBag)
    }
}
