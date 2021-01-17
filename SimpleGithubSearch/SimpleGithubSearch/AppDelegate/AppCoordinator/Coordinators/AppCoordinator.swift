//
//  AppCoordinator.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import UIKit

extension AppCoordinator {
    final class Coordinator: AppCoordinatorInterface {
        @LazyInject private var searchResultsCoordinator: SearchCoordinatorInterface
        @LazyInject private var searchDetailsCoordinator: SearchDetailsCoordinatorInterface

        private var container: UINavigationController!

        func start() -> UIViewController {
            searchResultsCoordinator.delegate = self

            let searchController = searchResultsCoordinator.start()
            container = UINavigationController(rootViewController: searchController)
            return container
        }
    }
}

extension AppCoordinator.Coordinator: SearchCoordinatorDelegate {
    func didSelect(_ details: SearchResults.ElementDetails) {
        let detailsController = searchDetailsCoordinator.start(with: details)
        container.pushViewController(detailsController, animated: true)
    }
}
