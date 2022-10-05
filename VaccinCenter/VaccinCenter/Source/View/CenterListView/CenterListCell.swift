//
//  CenterListCell.swift
//  VaccinCenter
//
//  Created by dale on 2022/10/05.
//

import UIKit

final class CenterListCell: UITableViewCell {
    static var identifier: String {
        return "\(self)"
    }

    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        ["센터명", "건물명", "주소", "업데이트 시간"].forEach {
            let label = UILabel()
            label.text = $0
            label.textColor = .gray
            label.setContentHuggingPriority(.init(251), for: .horizontal)
            label.setContentCompressionResistancePriority(.init(252), for: .horizontal)
            stackView.addArrangedSubview(label)
        }
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constraint.min
        return stackView
    }()

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        [titleLabel, buildingLabel, addressLabel, updatedLabel].forEach {
            $0.textColor = .black
            stackView.addArrangedSubview($0)
        }
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Constraint.min

        return stackView
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        let label = UILabel()
        [titleStackView, informationStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.axis = .horizontal
        stackView.spacing = Constraint.regular
        return stackView
    }()

    private let titleLabel = UILabel()
    private let buildingLabel = UILabel()
    private let addressLabel = UILabel()
    private let updatedLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layoutLabelStackView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layoutLabelStackView()
    }
}

// MARK: - Layout Section

private extension CenterListCell {
    func layoutLabelStackView() {
        addSubview(labelStackView)

        labelStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constraint.regular)
        }
    }
}
