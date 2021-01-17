//
//  UITableView+extensions.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import UIKit

extension UITableView {
    func dequeueReusableHeaderFooterView<HeaderFooterView: UITableViewHeaderFooterView>(_ type: HeaderFooterView.Type) -> HeaderFooterView {
        guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: type.reuseID) as? HeaderFooterView else {
            fatalError("No header footer view")
        }

        return headerFooterView
    }

    func registerHeaderFooterViewType<HeaderFooterView: UITableViewHeaderFooterView>(_ type: HeaderFooterView.Type) {
        let bundle = Bundle(for: HeaderFooterView.self)
        let nib = UINib(nibName: type.reuseID, bundle: bundle)

        register(nib, forHeaderFooterViewReuseIdentifier: type.reuseID)
    }

}
