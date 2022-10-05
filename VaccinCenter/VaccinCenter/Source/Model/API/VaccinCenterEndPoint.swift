//
//  VaccinCenterEndPoint.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation
import Alamofire

enum VaccinCenterEndPoint {
    case centers
}

extension VaccinCenterEndPoint: Requetable {
    var baseURL: URL? {
        return URL(string: "api.odcloud.kr/api")
    }

    var path: String {
        switch self {
        case .centers:
            return "/15077586/v1/centers"
        }
    }

    var url: URL? {
        return baseURL?.appendingPathComponent(path)
    }

    var headers: Alamofire.HTTPHeaders {
        return [HTTPHeader.accept("application/json")]
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .centers:
            return .get
        }
    }

}
