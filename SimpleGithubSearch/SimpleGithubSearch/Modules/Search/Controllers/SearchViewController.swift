//
//  ViewController.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import UIKit

extension Search {
    class ViewController: UIViewController {
        @LazyInject var viewModel: SearchViewModelInterface
        var searchController: UISearchController = UISearchController()

        override func viewDidLoad() {
            super.viewDidLoad()

            setupView()
            setupSerachControllerSetup()
        }

        private func setupView() {
            view?.backgroundColor = .systemBackground
            title = "Search"
        }

        private func setupSerachControllerSetup() {
            searchController.searchBar.placeholder = "Tap here to search repositories"
            searchController.searchBar.delegate = self
            searchController.searchBar.barStyle = .default
            searchController.delegate = self

            definesPresentationContext = true
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        }
    }
}

extension Search.ViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textDidChange(searchText)
    }
}
