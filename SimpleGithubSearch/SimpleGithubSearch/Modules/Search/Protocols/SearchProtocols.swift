//
//  SearchProtocols.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Foundation
import UIKit

struct Search {}

protocol SearchCoordinatorDelegate: class {
    func didSelect(_ details: SearchResults.ElementDetails)
}

protocol SearchCoordinatorInterface: class, CoordinatorInterface {
    var delegate: SearchCoordinatorDelegate? { get set }

    func textDidChange(_ searchText: String)
}

protocol SearchViewModelInterface: class {
    var coordinator: SearchCoordinatorInterface? { get set }

    func textDidChange(_ searchText: String)
}
