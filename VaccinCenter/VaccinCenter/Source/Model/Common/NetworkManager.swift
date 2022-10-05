//
//  NetworkManager.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import Foundation
import RxSwift
import Alamofire

final class NetworkManager {
    private init() {}
    static let shared = NetworkManager()

    func request(endPoint: Requetable) -> Single<Data> {
        return Single.create { observer in
            guard let url = endPoint.url else {
                observer(.failure(NetworkError.invalidURL))
                return Disposables.create()
            }

            let request: DataRequest = AF.request(url,
                                                  method: endPoint.method,
                                                  parameters: endPoint.parameter,
                                                  headers: endPoint.headers)

            request
                .validate(statusCode: 200..<300)
                .response { response in
                    if let data = response.data {
                        observer(.success(data))
                    } else {
                        observer(.failure(NetworkError.emptyData))
                    }
                }
            return Disposables.create()
        }
    }
}
