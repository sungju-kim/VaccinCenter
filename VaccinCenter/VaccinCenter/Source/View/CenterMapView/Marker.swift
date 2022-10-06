//
//  Marker.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import Foundation
import MapKit.MKAnnotation

final class Marker: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(center: Center) {
        self.title = center.centerName
        self.coordinate = CLLocationCoordinate2D(latitude: center.latitude,
                                                 longitude: center.longitued)
    }
}
