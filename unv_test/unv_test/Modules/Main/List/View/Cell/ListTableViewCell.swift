//
//  ListTableViewCell.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit
import SnapKit

class ListTableViewCell: UITableViewCell, Reusable {

    var model: ListCellModel? {
        didSet {
            handleUI()
        }
    }

    override var isSelected: Bool {
        didSet {
            handleIsSelected()
        }
    }

    private let containerView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .lightGray
        obj.clipsToBounds = true
        obj.layer.borderColor = UIColor.black.cgColor
        return obj
    }()

    private let titleLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.text = "TEST Test test"
        obj.numberOfLines = 0
        obj.textAlignment = .left
        return obj
    }()

    private let descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.textColor = .black
        obj.text = "TEST Test test"
        obj.numberOfLines = 0
        obj.textAlignment = .left
        return obj
    }()

    private lazy var stackView: UIStackView = {
        let obj = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        obj.distribution = .fillEqually
        obj.axis = .vertical
        return obj
    }()

    private let testView: UIView = {
        let obj = UIView()
        obj.backgroundColor = .black
        obj.clipsToBounds = true
        return obj
    }()

    private let favoriteImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.tintColor = .yellow
         return imageView
     }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutSubviews()
        containerView.layoutSubviews()
        containerView.layer.cornerRadius = 12
        testView.layer.cornerRadius = testView.bounds.height/2
    }

    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(containerView)
        containerView.addSubview(testView)
        containerView.addSubview(stackView)
        containerView.addSubview(favoriteImageView)

        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview().inset(8)
        }

        testView.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.verticalEdges.equalToSuperview().inset(12)
            make.leading.equalToSuperview().offset(16)
        }

        stackView.snp.makeConstraints { make in
            make.leading.equalTo(testView.snp.trailing).offset(12)
            make.verticalEdges.equalTo(testView)
        }

        favoriteImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

extension ListTableViewCell {
    private func handleUI() {
        guard let model else { return }
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        favoriteImageView.image = UIImage(systemName: model.isFavorite ? "star.fill" : "star")
    }

    private func handleIsSelected() {
        containerView.layer.borderWidth = isSelected ? 2 : 0
    }
}
