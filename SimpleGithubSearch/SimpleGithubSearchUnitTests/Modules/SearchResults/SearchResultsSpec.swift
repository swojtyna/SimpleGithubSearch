//
//  SearchResultsSpec.swift
//  SimpleGithubSearchUnitTests
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import Foundation
import Nimble
import Quick
@testable import SimpleGithubSearch

private func bePopulated(test: @escaping (_ displayRows: [SearchResults.DisplayRow]) -> Void = { _ in }) -> Predicate<SearchResults.State> {
    return Predicate.define("be <populated>") { expression, message in
        if let actual = try expression.evaluate(), case let .populated(displayRows) = actual {
            test(displayRows)
            return PredicateResult(status: .matches, message: message)
        }
        return PredicateResult(status: .doesNotMatch, message: message)
    }
}

private func beError(test: @escaping () -> Void = {}) -> Predicate<SearchResults.State> {
    return Predicate.define("be <empty>") { expression, message in
        if let actual = try expression.evaluate(), case .error = actual {
            test()
            return PredicateResult(status: .matches, message: message)
        }
        return PredicateResult(status: .doesNotMatch, message: message)
    }
}

private func beEmpty(test: @escaping () -> Void = {}) -> Predicate<SearchResults.State> {
    return Predicate.define("be <empty>") { expression, message in
        if let actual = try expression.evaluate(), case .empty = actual {
            test()
            return PredicateResult(status: .matches, message: message)
        }
        return PredicateResult(status: .doesNotMatch, message: message)
    }
}

class SearchResultsSpec: QuickSpec {
    override func spec() {
        describe("The search results") {
            var viewModel: SearchResultsViewModelInterface!
            context("when result for rxswift is not empty list with success") {
                beforeEach {
                    swreset()
                    swinject(type: SearchWebServiceInterface.self, object: SearchWebService.SuccessTestWebService())

                    viewModel = swinstance(SearchResultsViewModelInterface.self)
                    viewModel.search(for: "rxswift")
                }

                it("has 30 rows") {
                    expect(viewModel.currentState).toEventually(bePopulated { displayRows in
                        expect(displayRows.count) == 30
                    })
                }

                it("first row has title RxSwift, subtitle Reactive Programming in Swift 🌟 19513") {
                    expect(viewModel.currentState).toEventually(bePopulated { displayRows in
                        let testRow = displayRows[safe: 0]
                        expect(testRow?.title) == "RxSwift"
                        expect(testRow?.subtitle) == "Reactive Programming in Swift 🌟 19513"
                    })
                }
            }

            context("when result for rxswift is empty list with success") {
                beforeEach {
                    swreset()
                    swinject(type: SearchWebServiceInterface.self, object: SearchWebService.EmptyTestWebService())

                    viewModel = swinstance(SearchResultsViewModelInterface.self)
                    viewModel.search(for: "rxswift")
                }

                it("has empty state") {
                    expect(viewModel.currentState).toEventually(beEmpty())
                }
            }

            context("when result for rxswift is failure") {
                beforeEach {
                    swreset()
                    swinject(type: SearchWebServiceInterface.self, object: SearchWebService.FailureTestWebService())

                    viewModel = swinstance(SearchResultsViewModelInterface.self)
                    viewModel.search(for: "rxswift")
                }

                it("has error state") {
                    expect(viewModel.currentState).toEventually(beError())
                }
            }
        }
    }
}
