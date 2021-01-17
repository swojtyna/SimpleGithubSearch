//
//  NetworkClientInjections.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Swinject

extension NetworkClient {
    final class Injections {
        static func setup(_ container: Container) {
            container.register(NetworkClientInterface.self) { _ in
                Client()
            }
        }
    }
}
