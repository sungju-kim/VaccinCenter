//
//  Center.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation
import CoreLocation

struct Center {
    let id: Int
    let centerName: String
    let facilityName: String
    let address: String
    let latitude: Double
    let longitued: Double
    let updatedAt: String
    let phoneNumber: String
}

extension Center {
    func distance(from coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let userLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let destination = CLLocation(latitude: latitude, longitude: longitued)
        return userLocation.distance(from: destination)
    }

    func value(for type: InformationType) -> String {
        switch type {
        case .center:
            return centerName
        case .facility:
            return facilityName
        case .phoneNumber:
            return phoneNumber
        case .updateAt:
            return updatedAt
        case .address:
            return address
        }
    }
}
