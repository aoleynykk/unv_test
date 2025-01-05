//
//  SharedListView.swift
//  unv_test
//
//  Created by Alex Oliynyk on 05.01.2025.
//

import UIKit
import SnapKit

class SharedListView: UIView {

    let state: ListScreenState

    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.font = .systemFont(ofSize: 22, weight: .semibold)
        return obj
    }()

    let multiplyActionButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setTitleColor(.theme(.blue), for: .normal)
        obj.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        return obj
    }()

    let cancelButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setTitle("Cancel", for: .normal)
        obj.isHidden = true
        return obj
    }()

    let infoButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setImage(UIImage(systemName: "info.circle")?.withTintColor(.theme(.blue), renderingMode: .alwaysOriginal), for: .normal)
        return obj
    }()

    let tableView: UITableView = {
        let obj = UITableView()
        obj.backgroundColor = .clear
        obj.showsVerticalScrollIndicator = false
        obj.separatorStyle = .none
        return obj
    }()

    init(state: ListScreenState) {
        self.state = state
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white

        addSubview(titleLabel)
        addSubview(multiplyActionButton)
        addSubview(cancelButton)
        addSubview(infoButton)
        addSubview(tableView)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }

        multiplyActionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleLabel)
        }

        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(titleLabel)
        }

        infoButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(titleLabel)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }

        titleLabel.text = state.title
        multiplyActionButton.setTitle(state.multiplyActionButtonTitles.normal, for: .normal)
    }
}

extension SharedListView {
    func updateView(with value: Bool) {
        let buttonTitle = value ? state.multiplyActionButtonTitles.active : state.multiplyActionButtonTitles.normal
        multiplyActionButton.setTitle(buttonTitle, for: .normal)

        tableView.allowsSelection = value

        cancelButton.isHidden = !value

        infoButton.isHidden = value
    }
}
