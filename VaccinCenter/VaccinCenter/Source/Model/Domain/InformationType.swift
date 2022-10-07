//
//  InformationType.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import Foundation

enum InformationType: CaseIterable {
    case center
    case facility
    case phoneNumber
    case updateAt
    case address

    var title: String {
        switch self {
        case .center:
            return .Information.center
        case .facility:
            return .Information.bulding
        case .phoneNumber:
            return .Information.phoneNumber
        case .updateAt:
            return .Information.updateAt
        case .address:
            return .Information.address
        }
    }

    var imageName: String {
        switch self {
        case .center:
            return .ImageName.hospital
        case .facility:
            return .ImageName.building
        case .phoneNumber:
            return .ImageName.telephone
        case .updateAt:
            return .ImageName.chat
        case .address:
            return .ImageName.placeholder
        }
    }
}
