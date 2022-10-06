//
//  InformationCell.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/06.
//

import UIKit
import SnapKit

final class InformationCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.init(1000), for: .vertical)

        return label
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.init(1000), for: .vertical)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setAttribute()
        layoutTitleLabel()
        layoutImageView()
        layoutInfoLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setAttribute()
        layoutTitleLabel()
        layoutImageView()
        layoutInfoLabel()
    }
}

// MARK: - Configure

extension InformationCell {
    func configure(with viewModel: InformationViewModel) {
        imageView.image = UIImage(named: viewModel.imageName)
        titleLabel.text = viewModel.title
        infoLabel.text = viewModel.value
    }

    private func setAttribute() {
        backgroundColor = .systemBackground

        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize.zero
        layer.cornerRadius = 10
    }
}

// MARK: - Layout Section

private extension InformationCell {
    func layoutTitleLabel() {
        addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    func layoutImageView() {
        addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-Constraint.min)
            make.leading.trailing.top.equalToSuperview().inset(Constraint.regular)
        }
    }

    func layoutInfoLabel() {
        addSubview(infoLabel)

        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constraint.min)
            make.leading.trailing.bottom.equalToSuperview().inset(Constraint.min)
        }
    }
}
