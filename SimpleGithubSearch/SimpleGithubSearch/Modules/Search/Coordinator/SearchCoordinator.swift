//
//  SearchCoordinator.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import UIKit

extension Search {
    final class Coordinator: SearchCoordinatorInterface {
        weak var delegate: SearchCoordinatorDelegate?
        @LazyInject private var searchResults: SearchResultsCoordinatorInterface
        private weak var searchResultsViewModel: SearchResultsViewModelInterface?
        @LazyInject private var searchDetails: SearchDetailsCoordinatorInterface

        func start() -> UIViewController {
            let searchController = Search.ViewController()
            searchController.viewModel.coordinator = self

            searchResults.delegate = self

            if let resultsController = searchResults.start() as? SearchResults.ViewController {
                searchController.searchController = UISearchController(searchResultsController: resultsController)
                searchResultsViewModel = resultsController.viewModel
            }

            return searchController
        }

        func textDidChange(_ searchText: String) {
            searchResultsViewModel?.search(for: searchText)
        }
    }
}

extension Search.Coordinator: SearchResultsCoordinatorDelegate {
    func didSelect(_ details: SearchResults.ElementDetails) {
        delegate?.didSelect(details)
    }
}
