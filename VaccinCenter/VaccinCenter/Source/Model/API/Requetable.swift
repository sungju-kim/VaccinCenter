//
//  Requetable.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation
import Alamofire

protocol Requetable {
    var apiKey: String { get }
    var baseURL: URL? { get }
    var path: String { get }
    var url: URL? { get }
    var headers: HTTPHeaders { get }
    var parameter: [String: Any] { get }
    var method: Alamofire.HTTPMethod { get }
}
