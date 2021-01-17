//
//  SearchDetailsViewModel.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import Foundation

extension SearchDetails {
    final class ViewModel: SearchDetailsViewModelInterface {
        var coordinator: SearchDetailsCoordinatorInterface?
        var stateChanged: SearchDetails.StateChangeBlock?
        var currentState: State = .empty {
            didSet {
                stateChanged?(currentState)
            }
        }

        func showDetails(details: SearchResults.ElementDetails) {
            guard let url = URL(string: details.htmlUrl)
            else {
                currentState = .error
                return
            }

            currentState = .presented(DisplayData(request: URLRequest(url: url), title: details.title))
        }

    }
}
