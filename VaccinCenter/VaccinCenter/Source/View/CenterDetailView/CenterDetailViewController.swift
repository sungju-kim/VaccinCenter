//
//  CenterDetailViewController.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import UIKit

final class CenterDetailViewController: UIViewController {
    private var viewModel: CenterDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Configure

extension CenterDetailViewController {
    func configure(with viewModel: CenterDetailViewModel) {
        self.viewModel = viewModel
    }
}
