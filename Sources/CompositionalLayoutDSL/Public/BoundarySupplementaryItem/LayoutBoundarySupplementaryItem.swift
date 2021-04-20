//
//  LayoutBoundarySupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

/// A type that represents a boundary supplementary item in a compositional layout and provides
/// modifiers to configure boundary supplementary items.
///
/// You create custom boundary supplementary items by declaring types that conform to the
/// ``LayoutBoundarySupplementaryItem`` protocol. Implement the required
/// ``layoutBoundarySupplementaryItem`` computed property to provide the content and
/// configuration for your custom boundary supplementary item.
///
///     struct MyBoundarySupplementaryItem: LayoutBoundarySupplementaryItem {
///         var layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem {
///             BoundarySupplementaryItem(elementKind: "leadingKind")
///                 .width(.absolute(40))
///                 .alignment(.leading)
///         }
///     }
///
public protocol LayoutBoundarySupplementaryItem: LayoutSupplementaryItem {
    var layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem { get }
}

public extension LayoutBoundarySupplementaryItem {

    // MARK: - LayoutSupplementaryItem

    var layoutSupplementaryItem: LayoutSupplementaryItem { self }
}

extension LayoutBoundarySupplementaryItem {

    // MARK: - Boundary Supplementary Item mutable properties

    public func extendsBoundary(_ extendsBoundary: Bool) -> LayoutBoundarySupplementaryItem {
        valueModifier(extendsBoundary, keyPath: \.extendsBoundary)
    }

    public func pinToVisibleBounds(_ pinToVisibleBounds: Bool) -> LayoutBoundarySupplementaryItem {
        valueModifier(pinToVisibleBounds, keyPath: \.pinToVisibleBounds)
    }
}

extension LayoutBoundarySupplementaryItem {

    // MARK: - Supplementary Item mutable properties

    public func zIndex(zIndex: Int) -> LayoutBoundarySupplementaryItem {
        valueModifier(zIndex, keyPath: \.zIndex)
    }
}

extension LayoutBoundarySupplementaryItem {

    // MARK: - Content Insets

    public func contentInsets(value: CGFloat) -> LayoutBoundarySupplementaryItem {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutBoundarySupplementaryItem {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutBoundarySupplementaryItem {
        contentInsets(NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }

    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutBoundarySupplementaryItem {
        valueModifier(insets, keyPath: \.contentInsets)
    }
}

extension LayoutBoundarySupplementaryItem {

    // MARK: - Edge Spacing

    public func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutBoundarySupplementaryItem {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    public func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutBoundarySupplementaryItem {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    public func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutBoundarySupplementaryItem {
        edgeSpacing(
            NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        )
    }

    public func edgeSpacing(_ edgeSpacing: NSCollectionLayoutEdgeSpacing) -> LayoutBoundarySupplementaryItem {
        valueModifier(edgeSpacing, keyPath: \.edgeSpacing)
    }
}
