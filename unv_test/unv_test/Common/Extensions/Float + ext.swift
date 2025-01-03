//
//  Float + ext.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import Foundation

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
