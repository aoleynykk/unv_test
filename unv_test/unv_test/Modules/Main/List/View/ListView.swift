//
//  ListView.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit
import SnapKit

class ListView: UIView {

    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.text = "List"
        return obj
    }()

    let addToFavoritesButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setTitle("Add to Favorites", for: .normal)
        return obj
    }()

    let cancelButton: UIButton = {
        let obj = UIButton(type: .system)
        obj.setTitle("Cancel", for: .normal)
        obj.isHidden = true
        return obj
    }()

    let tableView: UITableView = {
        let obj = UITableView()
        obj.backgroundColor = .clear
        obj.showsVerticalScrollIndicator = false
        obj.separatorStyle = .none
        return obj
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white

        addSubview(titleLabel)
        addSubview(addToFavoritesButton)
        addSubview(cancelButton)
        addSubview(tableView)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }

        addToFavoritesButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleLabel)
        }

        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(titleLabel)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ListView {
    func updateView(with value: Bool) {
        let buttonTitle = value ? "Done" : "Add to Favorites"
        addToFavoritesButton.setTitle(buttonTitle, for: .normal)

        tableView.allowsSelection = value

        cancelButton.isHidden = !value
    }
}
