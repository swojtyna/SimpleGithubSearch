//
//  ThrottlingImplementation.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import Foundation

extension Throttling {
    class LatestThrottler: NSObject, ThrottlerInterface {
        var interval: TimeInterval
        private var block: Throttling.Block?

        required init(interval: TimeInterval) {
            self.interval = interval
        }

        func enqueue(block: @escaping Throttling.Block) {
            self.block = block

            NSObject.cancelPreviousPerformRequests(withTarget: self)
            perform(#selector(onAfterDelay), with: nil, afterDelay: interval, inModes: [RunLoop.Mode.common])
        }

        @objc func onAfterDelay() {
            block?()
            block = nil
        }
    }
}
