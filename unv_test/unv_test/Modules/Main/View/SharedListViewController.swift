//
//  SharedListViewController.swift
//  unv_test
//
//  Created by Alex Oliynyk on 05.01.2025.
//

import UIKit
import RxSwift
import RxCocoa

class SharedListViewController: UIViewController {

    private let mainView: SharedListView

    private let state: ListScreenState

    private var viewModel: SharedListViewModel

    private let disposeBag = DisposeBag()

    init(viewModel: SharedListViewModel, state: ListScreenState) {
        self.viewModel = viewModel
        self.state = state
        self.mainView = SharedListView(state: state)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let tabBarController = self.tabBarController {
            tabBarController.delegate = self
        }
        view = mainView
        initViewController()
    }

    private func initViewController() {
        mainView.tableView.registerReusableCell(ListTableViewCell.self)

        bindViewModel()

        setupButtons()
    }

    private func bindViewModel() {
        let dataSource = state == .allItems ? viewModel.items : viewModel.favourites

        dataSource
            .bind(to: mainView.tableView.rx.items) { [weak self] tableView, index, item in
                guard let self = self else { return UITableViewCell() }
                let cell: ListTableViewCell = tableView.dequeueReusableCell(for: IndexPath(row: index, section: 0))
                cell.model = item
                cell.state = state
                cell.isSelected = viewModel.selectedItems.contains(item) && (state == .allItems ? !item.isFavourite : true)
                return cell
            }
            .disposed(by: disposeBag)

        dataSource
            .map { $0.isEmpty }
            .bind(to: mainView.multiplyActionButton.rx.isHidden)
            .disposed(by: disposeBag)

        dataSource
            .map { $0.isEmpty }
            .bind(to: mainView.infoButton.rx.isHidden)
            .disposed(by: disposeBag)

        mainView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let item = dataSource.value[indexPath.row]
                if viewModel.isHandleMultiplyElementsSelected {
                    if viewModel.selectedItems.contains(item) {
                        viewModel.selectedItems.remove(item)
                    } else if state == .allItems ? !item.isFavourite : item.isFavourite {
                        viewModel.selectedItems.insert(item)
                    }
                    mainView.tableView.reloadRows(at: [indexPath], with: .none)
                }
            })
            .disposed(by: disposeBag)

        mainView.tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self, state == .favourites else { return }
                let item = dataSource.value[indexPath.row]
                if !viewModel.isHandleMultiplyElementsSelected {
                    AlertHelper.showForTime(title: "\(item.title) removed from favourite ;(")
                    viewModel.removeFromFavourites(item: item)
                }
            })
            .disposed(by: disposeBag)

        mainView.tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }

    private func setupButtons() {
        mainView.multiplyActionButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                viewModel.isHandleMultiplyElementsSelected.toggle()
                self.updateUIForAddToFavouritesSelection()
            })
            .disposed(by: disposeBag)

        mainView.cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                cancelButtonAction()
            })
            .disposed(by: disposeBag)

        mainView.infoButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                infoButtonAction()
            })
            .disposed(by: disposeBag)
    }
}

extension SharedListViewController {
    private func cancelButtonAction() {
        viewModel.selectedItems.removeAll()
        mainView.tableView.reloadData()
        viewModel.isHandleMultiplyElementsSelected = false
        mainView.updateView(with: viewModel.isHandleMultiplyElementsSelected)
    }

    private func infoButtonAction() {
        AlertHelper.show(message: "Swipe left to call action")
    }

    private func updateUIForAddToFavouritesSelection() {
        mainView.updateView(with: viewModel.isHandleMultiplyElementsSelected)

        if !viewModel.isHandleMultiplyElementsSelected {
            if viewModel.selectedItems.isEmpty {
                AlertHelper.showForTime(title: "You didn't choose any item :(")
                return
            }

            state == .allItems ? AlertHelper.showForTime(title: "\(viewModel.selectedItems.count) items added to favourite ;)") :  AlertHelper.showForTime(title: "\(viewModel.selectedItems.count) items removed from favourite ;(")

            viewModel.selectedItems.forEach { item in
                state == .allItems ? viewModel.addToFavourites(item: item) : viewModel.removeFromFavourites(item: item)
            }

            viewModel.selectedItems.removeAll()

            mainView.tableView.reloadData()
        }
    }
}

extension SharedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if viewModel.isHandleMultiplyElementsSelected || state == .favourites {
            return nil
        }

        let item = viewModel.items.value[indexPath.row]

        let favouriteAction = UIContextualAction(style: .normal, title: "Favourite") { _, _, completion in
            self.viewModel.addToFavourites(item: item)
            item.isFavourite ? AlertHelper.showForTime(title: "\(item.title) is already added to favourite") : AlertHelper.showForTime(title: "\(item.title) successfully added to favourite")
            completion(true)
        }
        favouriteAction.backgroundColor = .theme(.yellow)
        favouriteAction.image = UIImage(systemName: "star.fill")

        let configuration = UISwipeActionsConfiguration(actions: [favouriteAction])
        return configuration
    }
}

extension SharedListViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        cancelButtonAction()
    }
}
