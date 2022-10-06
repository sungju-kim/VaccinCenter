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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "지도"

        layoutMapView()
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
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
