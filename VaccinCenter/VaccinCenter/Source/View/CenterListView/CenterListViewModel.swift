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

    @NetworkInjector(keypath: \.locationRepository)
    private var locationRepository: LocationRepository

    let viewDidLoad = PublishRelay<Void>()
    let didLoadCenter = BehaviorRelay<[Center]>(value: [])
    let didScrollBottom = PublishRelay<Void>()
    let itemSelected = PublishRelay<IndexPath>()
    let prepareForPush = PublishRelay<CenterDetailViewModel>()

    let authorizationDenied = PublishRelay<Void>()

    let refresh = PublishRelay<Void>()
    let refreshed = PublishRelay<Bool>()

    init() {
        let centers = Observable.merge(viewDidLoad.asObservable(), didScrollBottom.asObservable())
            .withLatestFrom(didLoadCenter) { $1.count / 10 + 1 }
            .flatMapLatest(repository.requestCenters)
            .scan([Center](), accumulator: +)
            .map { $0.sorted { $0.updatedAt > $1.updatedAt } }
            .share()

        let nearest = locationRepository.didLoadLocation
            .withLatestFrom(centers) { ($1, $0) }
            .map { centers, userLocation in
                centers.sorted { $0.distance(from: userLocation) < $1.distance(from: userLocation) }
            }.share()

        let refreshNearest = refresh
            .withLatestFrom(nearest) { $1 }
            .share()

        itemSelected
            .withUnretained(self)
            .map { viewModel, indexPath in
                let center = viewModel.didLoadCenter.value[indexPath.item]
                return CenterDetailViewModel(center: center)}
            .bind(to: prepareForPush)
            .disposed(by: disposeBag)

        refresh
            .bind(onNext: locationRepository.updateLocation)
            .disposed(by: disposeBag)

        Observable.merge(centers, refreshNearest)
            .bind(to: didLoadCenter)
            .disposed(by: disposeBag)

        Observable.zip(refresh, locationRepository.authorizationDenied)
            .map { _ in }
            .bind(to: authorizationDenied)
            .disposed(by: disposeBag)

        Observable.merge(nearest.map { _ in }, locationRepository.authorizationDenied.asObservable())
            .map { false }
            .bind(to: refreshed)
            .disposed(by: disposeBag)
    }
}
