//
//  LocationRepositoryImpl.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import Foundation
import MapKit.MKAnnotation
import RxRelay
import RxSwift
import RxCoreLocation

final class LocationRepositoryImpl: NSObject, CLLocationManagerDelegate, LocationRepository {
    private let disposeBag = DisposeBag()
    private(set) var didLoadLocation = PublishRelay<CLLocationCoordinate2D>()
    private(set) var authorizationDenied = PublishRelay<Void>()

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()

    override init() {
        super.init()

        Observable.merge(
            locationManager.rx.didUpdateLocations.compactMap { $0.locations.last?.coordinate},
            locationManager.rx.didChangeAuthorization.compactMap { $0.manager.location?.coordinate }
        )
        .withUnretained(self)
        .map { $0.locationManager.stopUpdatingLocation()
            return $1 }
        .bind(to: didLoadLocation)
        .disposed(by: disposeBag)
    }

    func updateLocation() {
        locationManager.requestWhenInUseAuthorization()
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            authorizationDenied.accept(())
        }
    }
}
