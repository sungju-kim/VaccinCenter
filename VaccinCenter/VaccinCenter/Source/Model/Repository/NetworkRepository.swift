//
//  NetworkRepository.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation

class NetworkRepository {
    let networkManager = NetworkManager.shared

    func decode<T: Decodable>(_ type: T.Type, decoded data: Data?) -> T? {
        guard let data = data,
              let decodedData = try? JSONDecoder().decode(type.self, from: data) else { return nil }
        return decodedData
    }
}
