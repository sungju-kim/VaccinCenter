//
//  CenterDetailViewModel.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import Foundation
import RxSwift
import RxRelay

final class CenterDetailViewModel {
    private let disposeBag = DisposeBag()

    let viewDidLoad = PublishRelay<Void>()
    let didLoadCenter = PublishRelay<Center>()

    init(center: Center) {
        viewDidLoad
            .map { center }
            .bind(to: didLoadCenter)
            .disposed(by: disposeBag)
    }
}
