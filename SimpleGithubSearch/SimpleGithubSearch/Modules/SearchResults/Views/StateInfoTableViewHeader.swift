//
//  StateInfoTableViewHeader.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import UIKit

class StateInfoTableViewHeader: UITableViewHeaderFooterView {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        commonSetup()
    }

    func setMessage(_ message: String, showLoader: Bool = false) {
        messageLabel.text = message

        activityIndicator.isHidden = !showLoader

        if showLoader {
            activityIndicator.startAnimating()
        } else if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
    }

    private func commonSetup() {
        activityIndicator.stopAnimating()
        contentView.backgroundColor = .systemBackground
    }
}
