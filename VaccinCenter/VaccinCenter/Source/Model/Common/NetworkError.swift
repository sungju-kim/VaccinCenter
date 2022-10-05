//
//  NetworkError.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failToDecode
    case emptyData
    case badRequest
}
