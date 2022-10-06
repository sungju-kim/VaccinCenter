//
//  LocationRepositoryImpl.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import Foundation
import MapKit.MKAnnotation
import RxRelay

final class LocationRepositoryImpl: NSObject, CLLocationManagerDelegate, LocationRepository {
    private(set) var didLoadLocation = PublishRelay<CLLocationCoordinate2D>()

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func updateLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        didLoadLocation.accept(location.coordinate)
    }
}
