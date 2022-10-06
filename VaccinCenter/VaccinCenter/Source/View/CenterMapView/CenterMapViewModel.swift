//
//  CenterMapViewModel.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import Foundation
import RxSwift
import RxRelay
import MapKit.MKGeometry

final class CenterMapViewModel {
    private let disposeBag = DisposeBag()

    @NetworkInjector(keypath: \.locationRepository)
    var locationRepository: LocationRepository

    let viewDidLoad = PublishRelay<Void>()
    let didLoadMarker = PublishRelay<Marker>()
    let didSetRegion = PublishRelay<(MKCoordinateRegion, Bool)>()

    let currentPositionButtonTapped = PublishRelay<Void>()
    let centerButtonTapped = PublishRelay<Void>()

    init(center: Center) {

        Observable.merge(viewDidLoad.asObservable(), centerButtonTapped.asObservable())
            .map { Marker(center: center) }
            .bind(to: didLoadMarker)
            .disposed(by: disposeBag)

        Observable.merge( didLoadMarker.map { $0.coordinate }, locationRepository.didLoadLocation.asObservable())
            .map { (MKCoordinateRegion(center: $0, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), true) }
            .bind(to: didSetRegion)
            .disposed(by: disposeBag)

        currentPositionButtonTapped
            .bind(onNext: locationRepository.updateLocation)
            .disposed(by: disposeBag)

    }
}
