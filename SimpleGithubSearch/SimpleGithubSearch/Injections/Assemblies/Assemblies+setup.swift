//
//  Assemblies+setup.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Swinject

extension Assemblies {
    static func setup(container: Container = Assemblies.sharedContainer) {
        AppCoordinator.Injections.setup(container)

        NetworkClient.Injections.setup(container)
        SearchWebService.Injections.setup(container)

        Search.Injections.setup(container)
        SearchResults.Injections.setup(container)
        SearchDetails.Injections.setup(container)
    }
}
