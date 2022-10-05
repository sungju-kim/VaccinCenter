//
//  CenterDetailViewController.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import UIKit
import RxSwift
import RxAppState

final class CenterDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()

    private var viewModel: CenterDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
}

// MARK: - Configure

extension CenterDetailViewController {
    func configure(with viewModel: CenterDetailViewModel) {
        self.viewModel = viewModel

        rx.viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
    }
}
