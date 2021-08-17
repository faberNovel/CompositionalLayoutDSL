//
//  LayoutItem.swift
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

/// A type that represents an item in a compositional layout and provides
/// modifiers to configure items.
///
/// You create custom items by declaring types that conform to the ``LayoutItem``
/// protocol. Implement the required ``layoutItem`` computed property to
/// provide the content and configuration for your custom item.
///
/// ```swift
/// struct MyItem: LayoutItem {
///     var layoutItem: LayoutItem {
///         Item {
///             SupplementaryItem(elementKind: "badge")
///                 .containerAnchor(
///                     edges: [.top, .trailing],
///                     offset: .fractional(x: 0.5, y: -0.5)
///                 )
///                 .height(.absolute(20))
///                 .width(.absolute(20))
///         }
///     }
/// }
/// ```
///
public protocol LayoutItem {
    var layoutItem: LayoutItem { get }
}

extension LayoutItem {

    // MARK: - Content Insets

    /// Configure the amount of space between the content of the section and its boundaries.
    @warn_unqualified_access
    public func contentInsets(value: CGFloat) -> LayoutItem {
        return self.contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space between the content of the section and its boundaries.
    @warn_unqualified_access
    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutItem {
        return self.contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space between the content of the section and its boundaries.
    @warn_unqualified_access
    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutItem {
        return self.contentInsets(
            NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        )
    }

    /// Configure the amount of space between the content of the section and its boundaries.
    @warn_unqualified_access
    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutItem {
        valueModifier(insets, keyPath: \.contentInsets)
    }
}

extension LayoutItem {

    // MARK: - Edge Spacing

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    @warn_unqualified_access
    public func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutItem {
        return self.edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    @warn_unqualified_access
    public func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutItem {
        return self.edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    @warn_unqualified_access
    public func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutItem {
        return self.edgeSpacing(
            NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        )
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    @warn_unqualified_access
    public func edgeSpacing(_ edgeSpacing: NSCollectionLayoutEdgeSpacing) -> LayoutItem {
        valueModifier(edgeSpacing, keyPath: \.edgeSpacing)
    }
}
