//
//  SearchViewModel.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Foundation

extension Search {
    final class ViewModel: SearchViewModelInterface {
        weak var coordinator: SearchCoordinatorInterface?

        func textDidChange(_ searchText: String) {
            coordinator?.textDidChange(searchText)
        }
    }
}
