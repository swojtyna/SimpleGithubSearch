//
//  SearchResultsCoordinator.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import UIKit

extension SearchResults {
    class Coordinator: SearchResultsCoordinatorInterface {
        weak var delegate: SearchResultsCoordinatorDelegate?

        func start() -> UIViewController {
            let viewController = SearchResults.ViewController()
            viewController.viewModel.coordinator = self

            return viewController
        }

        func didSelect(_ details: SearchResults.ElementDetails) {
            delegate?.didSelect(details)
        }
    }
}
