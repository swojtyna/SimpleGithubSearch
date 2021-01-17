//
//  SearchDetailsCoordinator.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import UIKit

extension SearchDetails {
    class Coordinator: SearchDetailsCoordinatorInterface {
        weak var delegate: SearchDetailsCoordinatorDelegate?

        func start() -> UIViewController {
            fatalError("Please use start(with details:)")
        }

        func start(with details: SearchResults.ElementDetails) -> UIViewController {
            let viewController = SearchDetails.ViewController()
            viewController.viewModel.coordinator = self
            viewController.viewModel.showDetails(details: details)

            return viewController
        }
    }
}
