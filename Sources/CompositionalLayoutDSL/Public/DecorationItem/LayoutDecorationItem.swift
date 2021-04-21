//
//  LayoutDecorationItem.swift
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

/// A type that represents a decoration item in a compositional layout and provides
/// modifiers to configure decoration items.
///
/// You create custom decoration items by declaring types that conform to the
/// ``LayoutDecorationItem`` protocol. Implement the required ``layoutDecorationItem``
/// computed property to provide the content and configuration for your custom decoration item.
///
///     struct MyDecorationItem: LayoutDecorationItem {
///         var layoutDecorationItem: LayoutDecorationItem {
///             DecorationItem(elementKind: "backgroundKind")
///                 .contentInsets(value: 4)
///         }
///     }
///
public protocol LayoutDecorationItem: LayoutItem {
    var layoutDecorationItem: LayoutDecorationItem { get }
}

public extension LayoutDecorationItem {

    // MARK: - LayoutItem

    var layoutItem: LayoutItem { self }
}

extension LayoutDecorationItem {

    // MARK: - Decoration Item mutable properties

    /// Configure the vertical stacking order of the decoration item in relation to other items in the section.
    ///
    /// The default value of this property is 0, which means the decoration item appears below all
    /// other items in the section.
    public func zIndex(zIndex: Int) -> LayoutDecorationItem {
        valueModifier(zIndex, keyPath: \.zIndex)
    }
}

extension LayoutDecorationItem {

    // MARK: - Content Insets

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(value: CGFloat) -> LayoutDecorationItem {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutDecorationItem {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutDecorationItem {
        contentInsets(NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutDecorationItem {
        valueModifier(insets, keyPath: \.contentInsets)
    }
}

extension LayoutDecorationItem {

    // MARK: - Edge Spacing

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutDecorationItem {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutDecorationItem {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutDecorationItem {
        edgeSpacing(
            NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        )
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(_ edgeSpacing: NSCollectionLayoutEdgeSpacing) -> LayoutDecorationItem {
        valueModifier(edgeSpacing, keyPath: \.edgeSpacing)
    }
}
