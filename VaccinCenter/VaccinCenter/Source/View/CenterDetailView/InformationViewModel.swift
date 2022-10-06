//
//  InformationViewModel.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import Foundation

final class InformationViewModel {
    private let inforMationType: InformationType

    var title: String {
        return inforMationType.title
    }

    var imageName: String {
        return inforMationType.imageName
    }

    let value: String

    init(value: String, type: InformationType) {
        self.value = value
        self.inforMationType = type
    }
}
