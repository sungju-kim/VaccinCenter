//
//  Constant.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/07.
//

import Foundation

// MARK: - String + extension

extension String {
    enum ListView {
        static let title = "예방접종센터 리스트"
    }

    enum DetailView {
        static let rightBarButtonTitle = "지도"
    }

    enum Information {
        static let center = "센터명"
        static let bulding = "건물명"
        static let phoneNumber = "전화번호"
        static let updateAt = "업데이트 시간"
        static let address = "주소"
    }

    enum MapView {
        static let title = "지도"
        static let currentButtonTitle = "현재위치로"
        static let centerButtonTitle = "센터위치로"
    }

    enum ImageName {
        static let hospital = "hospital"
        static let building = "building"
        static let telephone = "telephone"
        static let chat = "chat"
        static let placeholder = "placeholder"
    }

    enum Alert {
        static let title = "위치정보 권한 필요", message = "위치정보 권한을 허용해주세요."
        static let set = "설정", cancel = "취소"
    }
}

// MARK: - Array + extension

extension Array where Element == String {
    enum Information {
        static let listTitle: [String] = [.Information.center, .Information.bulding, .Information.updateAt, .Information.address]
    }
}
