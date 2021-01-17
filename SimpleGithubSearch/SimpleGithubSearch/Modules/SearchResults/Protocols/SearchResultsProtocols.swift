//
//  SearchResultsProtocols.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Foundation
import UIKit

struct SearchResults {
    struct ElementDetails {
        let id: Int
        let title: String
        let htmlUrl: String
    }

    struct DisplayRow {
        let title: String
        let subtitle: String
        let tapRowAction: DisplayRowAction?
    }

    enum State {
        case populated([DisplayRow])
        case empty
        case error(String)
        case loading
    }

    typealias StateChangeBlock = (State) -> Void
    typealias DisplayRowAction = () -> Void
}

protocol SearchResultsViewModelInterface: class {
    var coordinator: SearchResultsCoordinatorInterface? { get set }
    var currentState: SearchResults.State { get }
    var stateChanged: SearchResults.StateChangeBlock? { get set }

    func search(for query: String)
}

protocol SearchResultsCoordinatorInterface: class, CoordinatorInterface {
    var delegate: SearchResultsCoordinatorDelegate? { get set }

    func didSelect(_ details: SearchResults.ElementDetails)
}

protocol SearchResultsCoordinatorDelegate: class {
    func didSelect(_ details: SearchResults.ElementDetails)
}
