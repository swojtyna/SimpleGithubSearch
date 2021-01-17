//
//  SearchResultsViewModel.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Foundation

extension SearchResults {
    final class ViewModel: SearchResultsViewModelInterface {
        weak var coordinator: SearchResultsCoordinatorInterface?
        var stateChanged: SearchResults.StateChangeBlock?
        var currentState: State = .loading {
            didSet {
                stateChanged?(currentState)
            }
        }

        @LazyInject private var searchWebService: SearchWebServiceInterface
        private let throttler = Throttling.LatestThrottler(interval: 0.25)

        func search(for query: String) {
            currentState = .loading
            throttler.enqueue { [weak self] in
                self?.searchFromWebService(for: query)
            }
        }

        private func searchFromWebService(for query: String) {
            guard !query.isEmpty else {
                currentState = .empty
                return
            }

            searchWebService.get(query: query) { [weak self] result in
                switch result {
                case .success(let response):
                    let rows = response.items.map { item in
                        DisplayRow(item: item,
                                   tapRowAction: { self?.coordinator?.didSelect(ElementDetails(item: item)) })
                    }
                    if rows.isEmpty {
                        self?.currentState = .empty
                    } else {
                        self?.currentState = .populated(rows)
                    }
                case .failure(let error):
                    self?.currentState = .error(error.readableMessage)
                }
            }
        }

    }
}

private extension SearchResults.DisplayRow {
    init(item: SearchWebService.Item, tapRowAction: @escaping SearchResults.DisplayRowAction) {
        title = item.name
        subtitle = (item.itemDescription ?? " ") + " 🌟 \(item.stargazersCount)"
        self.tapRowAction = tapRowAction
    }
}

private extension SearchResults.ElementDetails {
    init(item: SearchWebService.Item) {
        id = item.id
        title = item.name
        htmlUrl = item.htmlUrl
    }
}

private extension SearchWebService.Error {
    var readableMessage: String {
        var message = "Oops something went wrong"
        switch self {
        case .networkClientError(let networkError):
            switch networkError {
            case .invalidStausCode(let code):
                if code == 403 {
                    message = "API rate limit exceeded. Please try again later"
                }
            default: break
            }
        default: break
        }

        return message
    }
}
