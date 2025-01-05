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
        case red
        case yellow
        case lightGray
        case darkGray
        case gray
        case blue
    }

    static func theme(_ colorType: ColorType) -> UIColor {
        var color: UIColor?

        switch colorType {
        case .green:
            color = UIColor(named: "Green")
        case .red:
            color = UIColor(named: "Red")
        case .yellow:
            color = UIColor(named: "Yellow")
        case .lightGray:
            color = UIColor(named: "Light Gray")
        case .darkGray:
            color = UIColor(named: "Dark Gray")
        case .gray:
            color = UIColor(named: "Gray")
        case .blue:
            color = UIColor(named: "Blue")
        }

        // TODO: remove
        guard let color = color else {
            fatalError("Color \(colorType) not found")
        }

        return color
    }
}
