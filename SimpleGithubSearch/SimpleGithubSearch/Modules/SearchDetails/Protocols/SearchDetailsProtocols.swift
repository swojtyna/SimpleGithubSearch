//
//  SearchDetailsProtocols.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import UIKit

struct SearchDetails {
    struct DisplayData {
        let request: URLRequest
        let title: String
    }

    enum State {
        case presented(DisplayData)
        case error
        case empty
    }

    typealias StateChangeBlock = (State) -> Void
}

protocol SearchDetailsViewModelInterface: class {
    var coordinator: SearchDetailsCoordinatorInterface? { get set }
    var currentState: SearchDetails.State { get }
    var stateChanged: SearchDetails.StateChangeBlock? { get set }

    func showDetails(details: SearchResults.ElementDetails)
}

protocol SearchDetailsCoordinatorInterface: class, CoordinatorInterface {
    var delegate: SearchDetailsCoordinatorDelegate? { get set }

    func start(with details: SearchResults.ElementDetails) -> UIViewController
}

protocol SearchDetailsCoordinatorDelegate: class {
    func didSelect(_ details: SearchResults.ElementDetails)
}
