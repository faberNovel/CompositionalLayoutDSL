//
//  LayoutBoundarySupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

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

    /// Configure whether a boundary supplementary item extends the content area of the section
    /// or layout it's attached to.
    ///
    /// The default value of this property is true.
    public func extendsBoundary(_ extendsBoundary: Bool) -> LayoutBoundarySupplementaryItem {
        valueModifier(extendsBoundary, keyPath: \.extendsBoundary)
    }

    /// Configure whether a header or footer is pinned to the top or bottom visible boundary of
    /// the section or layout it's attached to.
    ///
    /// The default value of this property is `false`, which means that the boundary supplementary
    /// item (header or footer) remains in its original position during scrolling, and moves
    /// offscreen as its section or layout scrolls. Set the value of this property to true to pin
    /// the boundary supplementary item to the visible bounds of the section or layout it's
    /// attached to. This way, the boundary supplementary item is shown while any portion of the
    /// section or layout it's attached to is visible.
    public func pinToVisibleBounds(_ pinToVisibleBounds: Bool) -> LayoutBoundarySupplementaryItem {
        valueModifier(pinToVisibleBounds, keyPath: \.pinToVisibleBounds)
    }
}

extension LayoutBoundarySupplementaryItem {

    // MARK: - Supplementary Item mutable properties

    /// Configure the vertical stacking order of the decoration item in relation to other items in the section.
    ///
    /// The default value of this property is 0, which means the decoration item appears below all
    /// other items in the section.
    public func zIndex(zIndex: Int) -> LayoutBoundarySupplementaryItem {
        valueModifier(zIndex, keyPath: \.zIndex)
    }
}

extension LayoutBoundarySupplementaryItem {

    // MARK: - Content Insets

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(value: CGFloat) -> LayoutBoundarySupplementaryItem {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutBoundarySupplementaryItem {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutBoundarySupplementaryItem {
        contentInsets(NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutBoundarySupplementaryItem {
        valueModifier(insets, keyPath: \.contentInsets)
    }
}

extension LayoutBoundarySupplementaryItem {

    // MARK: - Edge Spacing

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutBoundarySupplementaryItem {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutBoundarySupplementaryItem {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
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

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(_ edgeSpacing: NSCollectionLayoutEdgeSpacing) -> LayoutBoundarySupplementaryItem {
        valueModifier(edgeSpacing, keyPath: \.edgeSpacing)
    }
}
