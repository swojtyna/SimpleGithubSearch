//
//  Assemblies+unitTests.swift
//  SimpleGithubSearchUnitTests
//
//  Created by Sebastian Wojtyna on 15/01/2021.
//

import Foundation
import Nimble
import Quick
import Swinject
@testable import SimpleGithubSearch

func swinstance<T>(_ type: T.Type) -> T! {
    return Assemblies.resolve(type)
}

func swinject<T>(type: T.Type, object: @escaping @autoclosure () -> T, inObjectScope: ObjectScope = .weak) {
    Assemblies.inject(type: type, object: object(), inObjectScope: inObjectScope)
}

func swreset() {
    Assemblies.reset()
}
