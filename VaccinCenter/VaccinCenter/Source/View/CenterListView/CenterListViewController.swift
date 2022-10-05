//
//  CenterListViewController.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import UIKit
import SnapKit

final class CenterListViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(CenterListCell.self, forCellReuseIdentifier: CenterListCell.identifier)
        return tableView
    }()

    private let scrollTopButton: UIButton = {
        let button: UIButton
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.image = .Custom.topAlignment
            configuration.contentInsets = .init(top: Constraint.semiRegular,
                                                leading: Constraint.semiRegular,
                                                bottom: Constraint.semiRegular,
                                                trailing: Constraint.semiRegular)

            button = UIButton(configuration: configuration)
        } else {
            button = UIButton()
            button.setImage(.Custom.topAlignment, for: .normal)
            button.contentEdgeInsets = UIEdgeInsets(top: Constraint.semiRegular,
                                                    left: Constraint.semiRegular,
                                                    bottom: Constraint.semiRegular,
                                                    right: Constraint.semiRegular)
        }
        button.backgroundColor = .systemBackground
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.cornerRadius = button.intrinsicContentSize.height / 2
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setAttribute()
        layoutTableView()
        layoutScrollTopButton()
    }
}

// MARK: Configure

extension CenterListViewController {
    private func setAttribute() {
        self.title = "예방접종센터 리스트"
        view.backgroundColor = .systemBackground
    }
}

// MARK: Layout Section

private extension CenterListViewController {
    func layoutTableView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func layoutScrollTopButton() {
        view.addSubview(scrollTopButton)

        scrollTopButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constraint.regular)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constraint.regular)
        }
    }
}
