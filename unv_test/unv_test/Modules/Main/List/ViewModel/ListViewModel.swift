//
//  ListViewModel.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import RxSwift
import RxRelay

class ListViewModel {

    var isAddToFavoritesSelected = false

    var selectedItems = Set<ListCellModel>()

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

    let favourites: BehaviorRelay<[ListCellModel]>

    init(favourites: BehaviorRelay<[ListCellModel]>) {
        self.favourites = favourites
    }

    func addToFavorites(item: ListCellModel) {
        if let index = items.value.firstIndex(where: { $0.title == item.title }) {
            var updatedItem = items.value[index]

            updatedItem.isFavorite = true

            favourites.accept(favourites.value + [updatedItem])

            var updatedItems = items.value
            updatedItems[index] = updatedItem

            items.accept(updatedItems)
        }
    }
}
