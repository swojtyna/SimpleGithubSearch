//
//  SearchWebServiceInjections.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Swinject

extension SearchWebService {
    final class Injections {
        static func setup(_ container: Container) {
            container.register(SearchWebServiceInterface.self) { _ in
                Service()
            }
        }
    }
}
