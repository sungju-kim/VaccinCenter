//
//  VaccinCenterEndPoint.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation
import Alamofire

enum VaccinCenterEndPoint {
    case centers(pageNumber: Int)
}

extension VaccinCenterEndPoint: Requetable {
    var apiKey: String {
        guard let file = Bundle.main.path(forResource: "Info", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_KEY"] as? String else { fatalError("Info.plist에 API Key를 설정해주세요.")}
        return key
    }

    var baseURL: URL? {
        return URL(string: "https://api.odcloud.kr/api")
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
    var parameter: [String: Any] {
        switch self {
        case .centers(let pageNumber):
            return ["page": pageNumber, "serviceKey": apiKey]
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .centers:
            return .get
        }
    }

}
