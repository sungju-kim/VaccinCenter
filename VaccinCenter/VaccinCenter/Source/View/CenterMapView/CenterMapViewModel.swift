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

    let viewDidLoad = PublishRelay<Void>()
    let didLoadMarker = PublishRelay<Marker>()
    let didSetRegion = PublishRelay<(MKCoordinateRegion, Bool)>()

    init(center: Center) {
        viewDidLoad
            .map { Marker(center: center) }
            .bind(to: didLoadMarker)
            .disposed(by: disposeBag)

        didLoadMarker
            .map { (MKCoordinateRegion(center: $0.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), true) }
            .bind(to: didSetRegion)
            .disposed(by: disposeBag)
    }
}
