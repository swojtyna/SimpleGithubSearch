//
//  ThrottlingProtocols.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import Foundation

struct Throttling {
    typealias Block = () -> Void
}

protocol ThrottlerInterface {
    var interval: TimeInterval { get set }

    init(interval: TimeInterval)
    func enqueue(block: @escaping Throttling.Block)
}
