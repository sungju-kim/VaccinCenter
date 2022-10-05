//
//  CenterResponseDTO.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation

struct CenterResponseDTO: Decodable {
    let data: [CenterDTO]
}

struct CenterDTO: Decodable {
    let id: String
    let centerName: String
    let facilityName: String
    let address: String
    let latitude: Double
    let longitued: Double
    let updatedAt: Date
    let phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case id, centerName, facilityName, address, updatedAt, phoneNumber
        case latitude = "lat"
        case longitued = "lng"
    }
}

extension CenterDTO {
    func toDomain() -> Center {
        return Center(id: id,
                      centerName: centerName,
                      facilityName: facilityName,
                      address: address,
                      latitude: latitude,
                      longitued: longitued,
                      updatedAt: updatedAt,
                      phoneNumber: phoneNumber)
    }
}
