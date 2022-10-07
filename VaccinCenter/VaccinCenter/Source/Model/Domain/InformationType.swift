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
            return "센터명"
        case .facility:
            return "건물명"
        case .phoneNumber:
            return "전화번호"
        case .updateAt:
            return "업데이트 시간"
        case .address:
            return "주소"
        }
    }

    var imageName: String {
        switch self {
        case .center:
            return "hospital"
        case .facility:
            return "building"
        case .phoneNumber:
            return "telephone"
        case .updateAt:
            return "chat"
        case .address:
            return "placeholder"
        }
    }
}
