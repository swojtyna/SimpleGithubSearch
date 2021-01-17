//
//  SearchWebService.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Foundation

private struct Configuration {
    static let baseUrl = "https://api.github.com/"
    static let endpoint = "search/repositories"
    static let headers = ["accept": "application/vnd.github.v3+json"]
}

extension SearchWebService {
    final class Service: SearchWebServiceInterface {
        @LazyInject private var client: NetworkClientInterface
        private let queue = DispatchQueue(label: "com.github.search.repositories.parse.queue")

        func get(query: String, completion: @escaping SearchWebService.Completion) {
            guard let escapedQuery = "?q=\(query)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
                completion(.failure(.encodedQueryError))
                return
            }

            client.get(baseurl: Configuration.baseUrl,
                       endpoint: Configuration.endpoint + escapedQuery,
                       headers: Configuration.headers) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.queue.async {
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: data)
                            DispatchQueue.main.async { completion(.success(response)) }
                        } catch {
                            DispatchQueue.main.async { completion(.failure(.parseError(error))) }
                        }
                    }
                case .failure(let error):
                    completion(.failure(.networkClientError(error)))
                }
            }
        }
    }
}
