//
//  CenterListViewController.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import UIKit
import RxSwift
import RxAppState
import RxCocoa
import SnapKit

final class CenterListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: CenterListViewModel?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(CenterListCell.self, forCellReuseIdentifier: CenterListCell.identifier)
        return tableView
    }()

    private let scrollTopButton: UIButton = {
        let button = UIButton()
        button.insertPadding()
        button.setImage(.Custom.topAlignment, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.cornerRadius = button.intrinsicContentSize.height / 2
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = .ListView.title

        layoutTableView()
        layoutScrollTopButton()
    }

    private func pushDetailView(with viewModel: CenterDetailViewModel) {
        let viewController = CenterDetailViewController()
        viewController.configure(with: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: Configure

extension CenterListViewController {
    func configure(with viewModel: CenterListViewModel) {
        self.viewModel = viewModel

        viewModel.didLoadCenter
            .bind(to: tableView.rx.items(cellIdentifier: CenterListCell.identifier,
                                         cellType: CenterListCell.self)) { _, center, cell in
                cell.configure(with: center)}
            .disposed(by: disposeBag)

        viewModel.prepareForPush
            .bind(onNext: pushDetailView)
            .disposed(by: disposeBag)

        scrollTopButton.rx.tap
            .map { (IndexPath(row: 0, section: 0), .top, true) }
            .bind(onNext: tableView.scrollToRow)
            .disposed(by: disposeBag)

        tableView.rx.reachedBottom
            .bind(to: viewModel.didScrollBottom)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)

        rx.viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
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
