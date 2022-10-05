//
//  CentersRepositoryImpl.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation
import RxSwift

final class CentersRepositoryImpl: NetworkRepository, CentersRepository {
    func requestCenters(page: Int) -> Single<CenterResponseDTO> {
        let endPoint = VaccinCenterEndPoint.centers(pageNumber: page)

        return Single.create { observer in
            self.networkManager
                .request(endPoint: endPoint)
                .subscribe { data in
                    guard let decodedData = self.decode(CenterResponseDTO.self, decoded: data) else {
                        observer(.failure(NetworkError.failToDecode))
                        return }
                    observer(.success(decodedData))
                } onFailure: { error in
                    observer(.failure(error))
                }
        }
    }
}
