//
//  NetworkContainer.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation

final class NetworkContainer {
    private init() {}

    static var shared = NetworkContainer()

    lazy var centersRepository: CentersRepository = CentersRepositoryImpl()
    lazy var locationRepository: LocationRepository = LocationRepositoryImpl()
}
