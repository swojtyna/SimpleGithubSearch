//
//  AppCoordinatorInjections.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import Swinject

extension AppCoordinator {
    final class Injections {
        static func setup(_ container: Container) {
            container.register(AppCoordinatorInterface.self) { _ in
                Coordinator()
            }
        }
    }
}
