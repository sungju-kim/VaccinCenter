//
//  CentersRepositoryImpl.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation
import RxSwift

final class CentersRepositoryImpl: NetworkRepository, CentersRepository {
    func requestCenters(page: Int) -> Single<[Center]> {
        let endPoint = VaccinCenterEndPoint.centers(pageNumber: page)

        return Single.create { observer in
            self.networkManager
                .request(endPoint: endPoint)
                .subscribe { data in
                    guard let decodedData = self.decode(CenterResponseDTO.self, decoded: data) else {
                        observer(.failure(NetworkError.failToDecode))
                        return }
                    let domain = decodedData.data.map { $0.toDomain() }
                    observer(.success(domain))
                } onFailure: { error in
                    observer(.failure(error))
                }
        }
    }
}
