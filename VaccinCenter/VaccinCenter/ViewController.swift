//
//  ViewController.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import UIKit

final class CenterListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setAttribute()
    }
}

// MARK: Configure

extension CenterListViewController {
    private func setAttribute() {
        self.title = "예방접종센터 리스트"
        view.backgroundColor = .systemBackground
    }
}
