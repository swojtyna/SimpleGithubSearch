//
//  SearchResultsTableViewAdapter.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import UIKit

private struct Configuration {
    static let heightForHeaderInSection: CGFloat = 200
}

private struct CustomMessageConfiguration {
    var message: String
    var showLoader: Bool
}

extension SearchResults {
    final class Adapter: NSObject, UITableViewDelegate, UITableViewDataSource {
        weak var tableView: UITableView?
        private var rows: [DisplayRow] = []
        private var customMessageConfiguration: CustomMessageConfiguration?

        func update(rows: [DisplayRow]) {
            self.rows = rows
            customMessageConfiguration = nil
            tableView?.reloadData()
        }

        func setCustom(message: String, showLoader: Bool) {
            customMessageConfiguration = CustomMessageConfiguration(message: message, showLoader: showLoader)
            tableView?.reloadData()
        }

        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let header = tableView.dequeueReusableHeaderFooterView(StateInfoTableViewHeader.self)

            if let customMessageConfiguration = customMessageConfiguration {
                header.setMessage(customMessageConfiguration.message, showLoader: customMessageConfiguration.showLoader)
            }

            return header
        }

        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return (customMessageConfiguration != nil) ? Configuration.heightForHeaderInSection : 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.reuseID, for: indexPath) as? SearchResultSubtitleTableViewCell,
                let row = rows[safe: indexPath.row] else { return UITableViewCell() }

            cell.textLabel?.text = row.title
            cell.detailTextLabel?.text = row.subtitle

            return cell
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (customMessageConfiguration != nil) ? 0 : rows.count
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let row = rows[safe: indexPath.row] else { return }

            row.tapRowAction?()
        }
    }
}
