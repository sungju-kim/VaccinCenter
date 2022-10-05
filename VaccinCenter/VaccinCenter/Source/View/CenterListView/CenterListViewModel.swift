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
    let didLoadCenter = PublishRelay<[Center]>()

    init() {
        bind()
    }
}

// MARK: - Bind

private extension CenterListViewModel {
    func bind() {
        viewDidLoad
            .withUnretained(self)
            .flatMapLatest { viewModel, _ in
                viewModel.repository.requestCenters(page: 1)}
            .bind(to: didLoadCenter)
            .disposed(by: disposeBag)
    }
}
