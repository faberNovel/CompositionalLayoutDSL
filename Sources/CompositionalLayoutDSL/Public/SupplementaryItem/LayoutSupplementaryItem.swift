//
//  LayoutSupplementaryItem.swift
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

/// A type that represents a supplementary item in a compositional layout and provides
/// modifiers to configure supplementary items.
///
/// You create custom supplementary items by declaring types that conform to the
/// ``LayoutSupplementaryItem`` protocol. Implement the required ``layoutSupplementaryItem``
/// computed property to provide the content and configuration for your custom supplementary item.
///
///     struct MySupplementaryItem: LayoutSupplementaryItem {
///         var layoutSupplementaryItem: LayoutSupplementaryItem {
///             SupplementaryItem(elementKind: UICollectionView.elementKindSectionHeader)
///                 .height(.absolute(40))
///                 .containerAnchor(edges: .top)
///                 .zIndex(zIndex: 10)
///         }
///     }
///
public protocol LayoutSupplementaryItem: LayoutItem {
    var layoutSupplementaryItem: LayoutSupplementaryItem { get }
}

public extension LayoutSupplementaryItem {
    // MARK: - LayoutItem

    var layoutItem: LayoutItem { self }
}

extension LayoutSupplementaryItem {

    // MARK: - Supplementary Item mutable properties

    /// Configure the vertical stacking order of the decoration item in relation to other items in the section.
    ///
    /// The default value of this property is 0, which means the decoration item appears below all
    /// other items in the section.
    public func zIndex(zIndex: Int) -> LayoutSupplementaryItem {
        valueModifier(zIndex, keyPath: \.zIndex)
    }
}

extension LayoutSupplementaryItem {

    // MARK: - Content Insets

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(value: CGFloat) -> LayoutSupplementaryItem {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutSupplementaryItem {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutSupplementaryItem {
        contentInsets(NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutSupplementaryItem {
        valueModifier(insets, keyPath: \.contentInsets)
    }
}

extension LayoutSupplementaryItem {

    // MARK: - Edge Spacing

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutSupplementaryItem {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutSupplementaryItem {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutSupplementaryItem {
        edgeSpacing(
            NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        )
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    public func edgeSpacing(_ edgeSpacing: NSCollectionLayoutEdgeSpacing) -> LayoutSupplementaryItem {
        valueModifier(edgeSpacing, keyPath: \.edgeSpacing)
    }
}
