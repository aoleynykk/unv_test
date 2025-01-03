//
//  SplashView.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit
import SnapKit

class SplashView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
    }
}
