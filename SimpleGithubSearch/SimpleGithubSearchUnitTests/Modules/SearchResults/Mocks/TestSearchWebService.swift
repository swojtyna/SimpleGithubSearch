//
//  TestSearchWebService.swift
//  SimpleGithubSearchUnitTests
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import Foundation
@testable import SimpleGithubSearch

extension SearchWebService {
    final class SuccessTestWebService: SearchWebServiceInterface {
        func get(query: String, completion: @escaping SearchWebService.Completion) {
            guard let url = Bundle(for: type(of: self)).url(forResource: "SearchResultSuccess", withExtension: "json"),
                let data = try? Foundation.Data(contentsOf: url),
                let response = try? JSONDecoder().decode(Response.self, from: data) else {
                DispatchQueue.main.async { completion(.success(.init(totalCount: 0, incompleteResults: false, items: []))) }
                return
            }

            DispatchQueue.main.async { completion(.success(response)) }
        }
    }

    final class FailureTestWebService: SearchWebServiceInterface {
        func get(query: String, completion: @escaping SearchWebService.Completion) {
            DispatchQueue.main.async { completion(.failure(.networkClientError(.invalidStausCode(403)))) }
        }
    }

    final class EmptyTestWebService: SearchWebServiceInterface {
        func get(query: String, completion: @escaping SearchWebService.Completion) {
            DispatchQueue.main.async { completion(.success(.init(totalCount: 0, incompleteResults: false, items: []))) }
        }
    }
}
