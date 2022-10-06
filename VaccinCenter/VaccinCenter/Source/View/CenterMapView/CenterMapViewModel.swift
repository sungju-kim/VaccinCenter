//
//  CenterMapViewModel.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import MapKit.MKGeometry

final class CenterMapViewModel {
    private let disposeBag = DisposeBag()

    @NetworkInjector(keypath: \.locationRepository)
    var locationRepository: LocationRepository

    let viewDidLoad = PublishRelay<Void>()
    let didLoadMarker = PublishRelay<Marker>()
    let didSetRegion = PublishRelay<(MKCoordinateRegion, Bool)>()

    let updatedPosition = PublishRelay<CLLocationCoordinate2D>()

    let currentPositionButtonTapped = PublishRelay<Void>()
    let centerButtonTapped = PublishRelay<Void>()

    init(center: Center) {

        viewDidLoad
            .bind(onNext: locationRepository.updateLocation)
            .disposed(by: disposeBag)

        viewDidLoad
            .map { Marker(center: center) }
            .bind(to: didLoadMarker)
            .disposed(by: disposeBag)

        locationRepository.didLoadLocation
            .bind(to: updatedPosition)
            .disposed(by: disposeBag)

        let currentPosition = currentPositionButtonTapped
            .withLatestFrom(updatedPosition) { $1 }
            .share()

        let centerPosition = centerButtonTapped
            .withLatestFrom(didLoadMarker) { $1.coordinate }
            .share()

        Observable.merge( didLoadMarker.map { $0.coordinate }, currentPosition, centerPosition)
            .map { (MKCoordinateRegion(center: $0, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), true) }
            .bind(to: didSetRegion)
            .disposed(by: disposeBag)

    }
}
