//
//  SearchProtocols.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//
// swiftlint:disable nesting

import Foundation

struct SearchWebService {
    struct Response: Codable {
        let totalCount: Int
        let incompleteResults: Bool
        let items: [Item]

        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case incompleteResults = "incomplete_results"
            case items
        }
    }

    struct Item: Codable {
        let id: Int
        let nodeID, name, fullName: String
        let itemDescription: String?
        let htmlUrl: String
        let stargazersCount: Int

        enum CodingKeys: String, CodingKey {
            case id
            case nodeID = "node_id"
            case name
            case itemDescription = "description"
            case fullName = "full_name"
            case htmlUrl = "html_url"
            case stargazersCount = "stargazers_count"
        }
    }

    enum Error: Swift.Error {
        case parseError(Swift.Error)
        case networkClientError(NetworkClient.Error)
        case encodedQueryError
    }

    typealias Completion = (Result<Response, Error>) -> Void
}

protocol SearchWebServiceInterface {
    func get(query: String, completion: @escaping SearchWebService.Completion)
}
