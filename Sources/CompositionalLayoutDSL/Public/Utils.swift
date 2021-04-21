//
//  Utils.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation

func with<T>(_ object: T, modifier: (inout T) -> Void) -> T {
    var copy = object
    modifier(&copy)
    return copy
}

@_functionBuilder
public enum ListResultBuilder<Element> {

    public static func buildBlock(_ components: [Element]...) -> [Element] {
        return components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: Element) -> [Element] {
        return [expression]
    }

    // For if statements without else
    // swiftlint:disable:next discouraged_optional_collection
    public static func buildOptional(_ component: [Element]?) -> [Element] {
        return component ?? []
    }

    // For if-else and switch
    public static func buildEither(first component: [Element]) -> [Element] {
        return component
    }

    // For if-else and switch
    public static func buildEither(second component: [Element]) -> [Element] {
        return component
    }

    public static func buildArray(_ components: [[Element]]) -> [Element] {
        return components.flatMap { $0 }
    }
}
