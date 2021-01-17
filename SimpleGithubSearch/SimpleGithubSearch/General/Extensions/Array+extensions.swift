//
//  Array+extensions.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    subscript (safe index: Index, default defaultValue: @autoclosure () -> Element) -> Element {
        return indices.contains(index) ? self[index] : defaultValue()
    }
}
