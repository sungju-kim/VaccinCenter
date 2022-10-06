//
//  CenterMapViewController.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import UIKit

final class CenterMapViewController: UIViewController {
    private var viewModel: CenterMapViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
}

// MARK: - Configure

extension CenterMapViewController {
    func configure(with viewModel: CenterMapViewModel) {
        self.viewModel = viewModel
    }
}
