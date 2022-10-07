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
        let button = UIButton()
        button.insertPadding()
        button.setTitle(.MapView.currentButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Constraint.min
        return button
    }()

    private let centerButton: UIButton = {
        let button = UIButton()
        button.insertPadding()
        button.setTitle(.MapView.centerButtonTitle, for: .normal)
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

        view.backgroundColor = .Custom.background
        title = .MapView.title

        layoutMapView()
        layoutButtonStackView()
    }

    private func presentAlert() {
        let alertController = UIAlertController(title: .Alert.title, message: .Alert.message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: .Alert.set, style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url, options: [:])
        }

        let cancelAction = UIAlertAction(title: .Alert.cancel, style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Configure

extension CenterMapViewController {
    func configure(with viewModel: CenterMapViewModel) {
        self.viewModel = viewModel

        viewModel.didLoadMarker
            .bind(onNext: mapView.addAnnotation)
            .disposed(by: disposeBag)

        viewModel.didSetRegion
            .bind(onNext: mapView.setRegion)
            .disposed(by: disposeBag)

        viewModel.updateAuthorization
            .bind(onNext: presentAlert)
            .disposed(by: disposeBag)

        currentPositionButton.rx.tap
            .bind(to: viewModel.currentPositionButtonTapped)
            .disposed(by: disposeBag)

        centerButton.rx.tap
            .bind(to: viewModel.centerButtonTapped)
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
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constraint.regular)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constraint.semiMax)
        }
    }
}
