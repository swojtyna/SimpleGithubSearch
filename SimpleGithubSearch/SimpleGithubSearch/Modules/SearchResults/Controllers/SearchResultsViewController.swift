//
//  SearchResultsViewController.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Foundation
import UIKit

extension SearchResults {
    final class ViewController: UITableViewController {
        @LazyInject var viewModel: SearchResultsViewModelInterface
        private lazy var adapter = Adapter()

        override func viewDidLoad() {
            super.viewDidLoad()

            setupTableView()
            registerCells()
            setupAdapter()

            viewModel.stateChanged = { [weak self] state in
                self?.update(accordingTo: state)
            }

            update(accordingTo: viewModel.currentState)
        }

        private func setupTableView() {
            tableView.delegate = adapter
            tableView.dataSource = adapter
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
        }

        private func registerCells() {
            tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.reuseID)
            tableView.registerHeaderFooterViewType(StateInfoTableViewHeader.self)
        }

        private func setupAdapter() {
            adapter.tableView = tableView
        }

        private func update(accordingTo state: SearchResults.State) {
            switch state {
            case .populated(let displayRows):
                adapter.update(rows: displayRows)
            case .empty:
                adapter.setCustom(message: "There is no result for such searched phrase", showLoader: false)
            case .error(let readableMessage):
                adapter.setCustom(message: readableMessage, showLoader: false)
            case .loading:
                adapter.setCustom(message: "Searching ...", showLoader: true)
            }
        }
    }
}
