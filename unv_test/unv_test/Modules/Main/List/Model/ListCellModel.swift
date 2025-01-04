//
//  ListCellModel.swift
//  unv_test
//
//  Created by Alex Oliynyk on 04.01.2025.
//

import Foundation

struct ListCellModel: Hashable {
    let id = UUID.init()
    let title: String
    let description: String
    var isFavorite: Bool = false
}
