//
//  Assemblies.swift
//  SimpleGithubSearch
//
//  Created by Sebastian Wojtyna on 14/01/2021.
//

import Swinject

struct Assemblies {
    static let sharedContainer = Container()

    static func resolve<T>(_ type: T.Type) -> T! {
        return sharedContainer.resolve(type)
    }

    static func resolve<T, Arg1>(_ type: T.Type, argument: Arg1) -> T! {
        return sharedContainer.resolve(type, argument: argument)
    }

    static func inject<T>(type: T.Type, object: @escaping @autoclosure () -> T, inObjectScope: ObjectScope = .weak) {
        sharedContainer.register(type) { _ in
            object()
        }.inObjectScope(inObjectScope)
    }

    static func reset() {
        sharedContainer.resetObjectScope(.container)
        sharedContainer.resetObjectScope(.graph)
        sharedContainer.resetObjectScope(.transient)
        sharedContainer.resetObjectScope(.weak)
    }

    static func removeAll() {
        sharedContainer.removeAll()
    }
}

/**
 Resolves type at initialization time and store it.
 */
@propertyWrapper
struct Inject<Value> {
    private(set) var wrappedValue: Value

    init() {
        wrappedValue = Assemblies.resolve(Value.self)
    }
}

/**
 Resolves type at use time. Does not store value.
 */
@propertyWrapper
struct DynamicInject<Value> {
    var wrappedValue: Value {
        return Assemblies.resolve(Value.self)
    }

    init() {}
}

/**
 Resolves type at use time and store it.
 */
@propertyWrapper
final class LazyInject<Value> {
    private lazy var value: Value = Assemblies.resolve(Value.self)

    var wrappedValue: Value {
        return value
    }
}
