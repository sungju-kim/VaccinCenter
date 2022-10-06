//
//  CenterMapViewController.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import UIKit
import MapKit
import RxSwift
import RxAppState

final class CenterMapViewController: UIViewController {
    private let disposeBag = DisposeBag()

    private var viewModel: CenterMapViewModel?

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }()

    private let currentPositionButton: UIButton = {
        let button: UIButton
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .init(top: Constraint.semiRegular,
                                                leading: Constraint.semiRegular,
                                                bottom: Constraint.semiRegular,
                                                trailing: Constraint.semiRegular)

            button = UIButton(configuration: configuration)
        } else {
            button = UIButton()
            button.contentEdgeInsets = UIEdgeInsets(top: Constraint.semiRegular,
                                                    left: Constraint.semiRegular,
                                                    bottom: Constraint.semiRegular,
                                                    right: Constraint.semiRegular)
        }
        button.setTitle("현재위치로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Constraint.min
        return button
    }()

    private let centerButton: UIButton = {
        let button: UIButton
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .init(top: Constraint.semiRegular,
                                                leading: Constraint.semiRegular,
                                                bottom: Constraint.semiRegular,
                                                trailing: Constraint.semiRegular)

            button = UIButton(configuration: configuration)
        } else {
            button = UIButton()
            button.contentEdgeInsets = UIEdgeInsets(top: Constraint.semiRegular,
                                                    left: Constraint.semiRegular,
                                                    bottom: Constraint.semiRegular,
                                                    right: Constraint.semiRegular)
        }
        button.setTitle("접종센터로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = Constraint.min
        return button
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = Constraint.min
        [currentPositionButton, centerButton].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "지도"

        layoutMapView()
        layoutButtonStackView()
    }

    private func createAnnotation(_ marker: Marker) {
        mapView.addAnnotation(marker)
    }
}

// MARK: - Configure

extension CenterMapViewController {
    func configure(with viewModel: CenterMapViewModel) {
        self.viewModel = viewModel

        viewModel.didLoadMarker
            .bind(onNext: createAnnotation)
            .disposed(by: disposeBag)

        viewModel.didSetRegion
            .bind(onNext: mapView.setRegion)
            .disposed(by: disposeBag)

        rx.viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
    }
}

// MARK: - Layout Section

private extension CenterMapViewController {
    func layoutMapView() {
        view.addSubview(mapView)

        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }

    func layoutButtonStackView() {
        view.addSubview(buttonStackView)

        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constraint.regular)
        }
    }
}
