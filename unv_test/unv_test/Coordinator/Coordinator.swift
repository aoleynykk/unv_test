//
//  Coordinator.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
