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

/// A custom parameter attribute that constructs list of `Element` from closures.
///
/// You typically use ``ListResultBuilder`` (or a typealias of it) as a parameter attribute for
/// elements producing closure parameters, allowing those closures to provide multiple elements
/// For example, the following `HGroup` initialiser accepts a closure that produces
/// one or more items via the view builder.
///
///     struct HGroup {
///         init(@ListResultBuilder<LayoutItem> subItems: () -> [LayoutItem]) { /* ... */ }
///     }
///
/// Clients of this function can use multiple-statement closures to provide
/// several elements, as shown in the following example:
///
///     HGroup {
///         Item().width(.fractionalWidth(0.5))
///         if condition {
///             VGroup(count: 3) { Item() }
///                 .width(.fractionalWidth(0.5))
///         } else {
///             Item().width(.fractionalWidth(0.5))
///         }
///     }
///
@_functionBuilder
public enum ListResultBuilder<Element> {

    public static func buildBlock(_ components: [Element]...) -> [Element] {
        return components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: Element) -> [Element] {
        return [expression]
    }

    /// Provides support for “if” statements in multi-statement closures,
    /// producing an optional view that is visible only when the condition
    /// evaluates to `true`.
    // swiftlint:disable:next discouraged_optional_collection
    public static func buildOptional(_ component: [Element]?) -> [Element] {
        return component ?? []
    }

    /// Provides support for "if" and "switch" statements in multi-statement closures,
    /// producing conditional content for the "then" branch.
    public static func buildEither(first component: [Element]) -> [Element] {
        return component
    }

    /// Provides support for "if-else" and "switch" statements in multi-statement closures,
    /// producing conditional content for the "else" branch.
    public static func buildEither(second component: [Element]) -> [Element] {
        return component
    }

    public static func buildArray(_ components: [[Element]]) -> [Element] {
        return components.flatMap { $0 }
    }
}

@available(iOS 14.0, tvOS 14.0, *)
extension ListResultBuilder {

    /// Provides support for "if" statements with `#available()` clauses in
    /// multi-statement closures, producing conditional content for the "then"
    /// branch, i.e. the conditionally-available branch.
    public static func buildLimitedAvailability(_ component: [Element]) -> [Element] {
        return component
    }
}
