//
//  SharedListViewModel.swift
//  unv_test
//
//  Created by Alex Oliynyk on 05.01.2025.
//

import UIKit
import RxRelay
import RxSwift

class SharedListViewModel {

    let items = BehaviorRelay<[ListCellModel]>(value: [
        ListCellModel(title: "Test1", description: "Description1"),
        ListCellModel(title: "Test2", description: "Description2"),
        ListCellModel(title: "Test3", description: "Description3"),
        ListCellModel(title: "Test4", description: "Description4"),
        ListCellModel(title: "Test5", description: "Description5"),
        ListCellModel(title: "Test6", description: "Description6"),
        ListCellModel(title: "Test7", description: "Description7"),
        ListCellModel(title: "Test8", description: "Description8"),
        ListCellModel(title: "Test9", description: "Description9"),
        ListCellModel(title: "Test10", description: "Description10"),
        ListCellModel(title: "Test11", description: "Description11"),
        ListCellModel(title: "Test12", description: "Description12"),
        ListCellModel(title: "Test13", description: "Description13"),
        ListCellModel(title: "Test14", description: "Description14"),
        ListCellModel(title: "Test15", description: "Description15"),
        ListCellModel(title: "Test16", description: "Description16"),
        ListCellModel(title: "Test17", description: "Description17"),
        ListCellModel(title: "Test18", description: "Description18"),
        ListCellModel(title: "Test19", description: "Description19"),
        ListCellModel(title: "Test20", description: "Description20")
    ])

    let favourites = BehaviorRelay<[ListCellModel]>(value: [])

    var isHandleMultiplyElementsSelected = false

    var selectedItems = Set<ListCellModel>()

    func removeFromFavourites(item: ListCellModel) {
        favourites.accept(favourites.value.filter { $0.id != item.id })
        updateItem(item, isFavourite: false)
    }

    func addToFavourites(item: ListCellModel) {
        guard !item.isFavourite else { return }
        updateItem(item, isFavourite: true)
    }

    private func updateItem(_ item: ListCellModel, isFavourite: Bool) {
        guard let index = items.value.firstIndex(where: { $0.id == item.id }) else { return }
        var updatedItem = items.value[index]
        updatedItem.isFavourite = isFavourite
        if isFavourite { favourites.accept(favourites.value + [updatedItem]) }

        var updatedItems = items.value
        updatedItems[index] = updatedItem
        items.accept(updatedItems)
    }
}
