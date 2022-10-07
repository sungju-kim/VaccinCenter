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
    let didLoadTitle = PublishRelay<String>()
    let didLoadInformation = PublishRelay<[InformationViewModel]>()
    let mapButtonTapped = PublishRelay<Void>()
    let prepareForPush = PublishRelay<CenterMapViewModel>()

    init(center: Center) {
        viewDidLoad
            .map { center.centerName }
            .bind(to: didLoadTitle)
            .disposed(by: disposeBag)

        viewDidLoad
            .map { InformationType.allCases.map { InformationViewModel(value: center.value(for: $0), type: $0) } }
            .bind(to: didLoadInformation)
            .disposed(by: disposeBag)

        mapButtonTapped
            .map { CenterMapViewModel(center: center) }
            .bind(to: prepareForPush)
            .disposed(by: disposeBag)
    }
}
