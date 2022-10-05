//
//  CentersRepository.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation
import RxSwift

protocol CentersRepository {
    func requestCenters(page: Int) -> Single<CenterResponseDTO>
}
