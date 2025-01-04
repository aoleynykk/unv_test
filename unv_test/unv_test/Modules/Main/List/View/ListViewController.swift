//
//  ListViewController.swift
//  unv_test
//
//  Created by Alex Oliynyk on 03.01.2025.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {

    private let mainView = ListView()

    private var viewModel: ListViewModel

    private let disposeBag = DisposeBag()

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        initViewController()
    }

    private func initViewController() {
        mainView.tableView.registerReusableCell(ListTableViewCell.self)

        bindViewModel()

        setupAddToFavoritesButton()
    }

    private func bindViewModel() {
        viewModel.items
            .bind(to: mainView.tableView.rx.items) { [weak self] tableView, index, item in
                guard let self = self else { return UITableViewCell() }
                let cell: ListTableViewCell = tableView.dequeueReusableCell(for: IndexPath(row: index, section: 0))
                cell.model = item
                cell.isSelected = viewModel.selectedItems.contains(item) && !item.isFavorite
                return cell
            }
            .disposed(by: disposeBag)

        mainView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let item = viewModel.items.value[indexPath.row]
                if viewModel.isAddToFavoritesSelected {
                    if viewModel.selectedItems.contains(item) {
                        viewModel.selectedItems.remove(item)
                    } else if !item.isFavorite {
                        viewModel.selectedItems.insert(item)
                    }
                    mainView.tableView.reloadRows(at: [indexPath], with: .none)
                }
            })
            .disposed(by: disposeBag)

        mainView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    private func setupAddToFavoritesButton() {
        mainView.addToFavoritesButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                viewModel.isAddToFavoritesSelected.toggle()
                self.updateUIForAddToFavoritesSelection()
            })
            .disposed(by: disposeBag)

        mainView.cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                cancelButtonAction()
            })
            .disposed(by: disposeBag)
    }

    private func cancelButtonAction() {
        viewModel.selectedItems.removeAll()
        mainView.tableView.reloadData()
        viewModel.isAddToFavoritesSelected = false
        mainView.updateView(with: viewModel.isAddToFavoritesSelected)
    }

    private func updateUIForAddToFavoritesSelection() {
        mainView.updateView(with: viewModel.isAddToFavoritesSelected)

        if !viewModel.isAddToFavoritesSelected {
            if viewModel.selectedItems.isEmpty {
                AlertHelper.showForTime(title: "You didn't choose any item :(")
                return
            }

            AlertHelper.showForTime(title: "\(viewModel.selectedItems.count) items added to favorite ;)")

            viewModel.selectedItems.forEach { item in
                viewModel.addToFavorites(item: item)
            }

            viewModel.selectedItems.removeAll()

            mainView.tableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if viewModel.isAddToFavoritesSelected {
            return nil
        }

        let item = viewModel.items.value[indexPath.row]

        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite") { _, _, completion in
            self.viewModel.addToFavorites(item: item)
            item.isFavorite ? AlertHelper.showForTime(title: "\(item.title) is already added to favorite") : AlertHelper.showForTime(title: "\(item.title) successfully added to favorite")
            completion(true)
        }
        favoriteAction.backgroundColor = .systemYellow
        favoriteAction.image = UIImage(systemName: "star.fill")

        let configuration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return configuration
    }
}
