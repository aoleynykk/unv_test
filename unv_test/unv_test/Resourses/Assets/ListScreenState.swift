//
//  ListScreenState.swift
//  unv_test
//
//  Created by Alex Oliynyk on 05.01.2025.
//

import Foundation

enum ListScreenState {
    case allItems
    case favourites

    var title: String {
        switch self {
        case .allItems:
            return "All Items"
        case .favourites:
            return "Favourite"
        }
    }

    var multiplyActionButtonTitles: (normal: String, active: String) {
        switch self {
        case .allItems:
            return (normal: "Add Multiple", active: "Add")
        case .favourites:
            return (normal: "Delete Multiple", active: "Delete")
        }
    }
}
