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
    let id: Int
    let centerName: String
    let facilityName: String
    let address: String
    let latitude: String
    let longitued: String
    let updatedAt: String
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
                      latitude: Double(latitude) ?? 0,
                      longitued: Double(longitued) ?? 0,
                      updatedAt: updatedAt,
                      phoneNumber: phoneNumber)
    }
}
