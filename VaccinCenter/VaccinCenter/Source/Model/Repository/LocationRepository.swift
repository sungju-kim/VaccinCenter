//
//  LocationRepository.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import Foundation
import MapKit.MKAnnotation
import RxRelay

protocol LocationRepository {
    var didLoadLocation: PublishRelay<CLLocationCoordinate2D> { get }
    var authorizationDenied: PublishRelay<Void> { get }
    func updateLocation()
}
