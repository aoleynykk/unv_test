//
//  ProgressHelperView.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import Foundation
import UIKit

class ProgressHelperView: UIView {

    var activityIndicator: ActivityIndicator = {
        let obj = ActivityIndicator()
        obj.tintColor = .theme(.blue)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.2)

        addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { (make) in
            make.size.equalTo(64)
            make.center.equalToSuperview()
        }

    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        activityIndicator.startAnimating()
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}
