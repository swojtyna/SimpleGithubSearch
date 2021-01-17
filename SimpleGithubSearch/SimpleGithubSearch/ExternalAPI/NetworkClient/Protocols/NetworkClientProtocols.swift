//
//  NetworkClientProtocols.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Foundation

struct NetworkClient {
    enum Error: Swift.Error {
        case invalidUrl
        case noDataError
        case invalidStausCode(Int)
        case urlSessionError(Swift.Error)
    }

    typealias Completion = (Result<Data, Error>) -> Void
}

protocol NetworkClientInterface: class {
    func get(baseurl: String, endpoint: String, headers: [String: String], completion: @escaping NetworkClient.Completion)
}
