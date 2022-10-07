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
    let itemSelected = PublishRelay<IndexPath>()
    let prepareForPush = PublishRelay<CenterDetailViewModel>()

    let refresh = PublishRelay<Void>()
    let refreshed = PublishRelay<Bool>()

    init() {
        Observable.merge(viewDidLoad.asObservable(), didScrollBottom.asObservable())
            .withLatestFrom(didLoadCenter) { $1.count / 10 + 1 }
            .flatMapLatest(repository.requestCenters)
            .scan([Center](), accumulator: +)
            .map { $0.sorted { $0.updatedAt > $1.updatedAt } }
            .bind(to: didLoadCenter)
            .disposed(by: disposeBag)

        itemSelected
            .withUnretained(self)
            .map { viewModel, indexPath in
                let center = viewModel.didLoadCenter.value[indexPath.item]
                return CenterDetailViewModel(center: center)}
            .bind(to: prepareForPush)
            .disposed(by: disposeBag)
    }
}
