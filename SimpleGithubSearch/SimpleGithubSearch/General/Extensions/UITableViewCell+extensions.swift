//
//  UITableViewCell+extensions.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import UIKit

protocol Reusbale {}

extension Reusbale {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusbale {}
extension UITableViewHeaderFooterView: Reusbale {}
