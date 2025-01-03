//
//  Color + ext.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit

extension UIColor {
    enum ColorType {
        case green
    }

    static func theme(_ colorType: ColorType) -> UIColor {
        var color: UIColor?

        switch colorType {
        case .green:
            color = UIColor(named: "Green")
        }

        // TODO: remove
        guard let color = color else {
            fatalError("Color \(colorType) not found")
        }

        return color
    }
}
