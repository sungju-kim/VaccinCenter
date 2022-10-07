//
//  CenterDetailViewController.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import UIKit
import RxSwift
import SnapKit
import RxAppState

final class CenterDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()

    private var viewModel: CenterDetailViewModel?

    private lazy var informationView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: Constraint.semiRegular,
                                   leading: Constraint.semiRegular,
                                   bottom: Constraint.semiRegular,
                                   trailing: Constraint.semiRegular)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let lastItem = NSCollectionLayoutItem(layoutSize: groupSize)
        lastItem.contentInsets = .init(top: Constraint.semiRegular,
                                   leading: Constraint.semiRegular,
                                   bottom: Constraint.semiRegular,
                                   trailing: Constraint.semiRegular)

        let containerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(100))

        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: containerSize, subitems: [group, group, lastItem])

        let section = NSCollectionLayoutSection(group: containerGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray5

        collectionView.register(InformationCell.self, forCellWithReuseIdentifier: InformationCell.identifier)

        return collectionView
    }()

    private let mapButton = UIBarButtonItem(title: .DetailView.rightBarButtonTitle)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = mapButton

        layoutInformationView()
    }

    func pushToMapView(with viewModel: CenterMapViewModel) {
        let viewController = CenterMapViewController()
        viewController.configure(with: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

}

// MARK: - Configure

extension CenterDetailViewController {
    func configure(with viewModel: CenterDetailViewModel) {
        self.viewModel = viewModel

        viewModel.didLoadTitle
            .withUnretained(self)
            .bind { $0.title = $1 }
            .disposed(by: disposeBag)

        viewModel.didLoadInformation
            .bind(to: informationView.rx.items(cellIdentifier: InformationCell.identifier, cellType: InformationCell.self)) { _, viewModel, cell in
                cell.configure(with: viewModel)}
            .disposed(by: disposeBag)

        viewModel.prepareForPush
            .bind(onNext: pushToMapView)
            .disposed(by: disposeBag)

        mapButton.rx.tap
            .bind(to: viewModel.mapButtonTapped)
            .disposed(by: disposeBag)

        rx.viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
    }
}

// MARK: - Layout Section

private extension CenterDetailViewController {
    func layoutInformationView() {
        view.addSubview(informationView)

        informationView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
