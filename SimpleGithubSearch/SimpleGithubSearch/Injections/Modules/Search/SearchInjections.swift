//
//  SearchInjections.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Swinject

extension Search {
    final class Injections {
        static func setup(_ container: Container) {
            setupViewModels(container)
            setupCoordinators(container)
        }

        private static func setupViewModels(_ container: Container) {
            container.register(SearchViewModelInterface.self) { _ in
                ViewModel()
            }
        }

        private static func setupCoordinators(_ container: Container) {
            container.register(SearchCoordinatorInterface.self) { _ in
                Coordinator()
            }
        }
    }
}
