//
//  SearchDetailsInjections.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import Swinject

extension SearchDetails {
    final class Injections {
        static func setup(_ container: Container) {
            setupViewModels(container)
            setupCoordinators(container)
        }

        private static func setupViewModels(_ container: Container) {
            container.register(SearchDetailsViewModelInterface.self) { _ in
                ViewModel()
            }
        }

        private static func setupCoordinators(_ container: Container) {
            container.register(SearchDetailsCoordinatorInterface.self) { _ in
                Coordinator()
            }
        }
    }
}
