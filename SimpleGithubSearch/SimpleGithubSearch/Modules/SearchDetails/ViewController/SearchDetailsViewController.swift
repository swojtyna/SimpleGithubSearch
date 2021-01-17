//
//  SearchDetailsViewController.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import UIKit
import WebKit

extension SearchDetails {
    final class ViewController: UITableViewController, WKUIDelegate {
        @LazyInject var viewModel: SearchDetailsViewModelInterface
        var webView: WKWebView!

        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            viewModel.stateChanged = { [weak self] state in
                self?.update(accordingTo: state)
            }

            update(accordingTo: viewModel.currentState)
        }

        private func update(accordingTo state: SearchDetails.State) {
            switch state {
            case .presented(let displayData):
                webView.load(displayData.request)
                title = displayData.title
            case .error:
                showErroAlert()
            case .empty:
                break
            }
        }

        private func showErroAlert() {
            let alert = UIAlertController(title: "Error",
                                          message: "There was a problem with url. Try again later",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))

            present(alert, animated: true, completion: nil)
        }
    }
}
