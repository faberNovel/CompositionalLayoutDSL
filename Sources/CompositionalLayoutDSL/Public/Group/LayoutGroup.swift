//
//  LayoutGroup.swift
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

/// A type that represents a group in a compositional layout and provides
/// modifiers to configure groups.
///
/// You create custom groups by declaring types that conform to the
/// ``LayoutGroup`` protocol. Implement the required ``layoutGroup``
/// computed property to provide the content and configuration for your custom group.
///
/// ```swift
/// struct MyGroup: LayoutGroup {
///     var layoutGroup: LayoutGroup {
///         HGroup(count: 4) {
///             Item()
///         }
///         .height(.absolute(300))
///         .interItemSpacing(.fixed(8))
///     }
/// }
/// ```
///
public protocol LayoutGroup: LayoutItem {
    var layoutGroup: LayoutGroup { get }
}

public extension LayoutGroup {

    // MARK: - LayoutItem

    var layoutItem: LayoutItem { layoutGroup }
}

extension LayoutGroup {

    // MARK: - Group Mutable properties

    /// Add an array of the supplementary items that are anchored to the group.
    @warn_unqualified_access
    public func supplementaryItems(
        @LayoutSupplementaryItemBuilder _ supplementaryItems: () -> [LayoutSupplementaryItem]
    ) -> LayoutGroup {
        let supplementaryItems = supplementaryItems().map(SupplementaryItemBuilder.make(from:))
        return valueModifier { $0.supplementaryItems.append(contentsOf: supplementaryItems) }
    }

    /// Configure the amount of space between the items along the layout axis of the group.
    @warn_unqualified_access
    public func interItemSpacing(_ interItemSpacing: NSCollectionLayoutSpacing?) -> LayoutGroup {
        valueModifier(interItemSpacing, keyPath: \.interItemSpacing)
    }
}

extension LayoutGroup {

    // MARK: - Content Insets

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    @warn_unqualified_access
    public func contentInsets(value: CGFloat) -> LayoutGroup {
        return self.contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    @warn_unqualified_access
    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutGroup {
        return self.contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    @warn_unqualified_access
    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutGroup {
        return self.contentInsets(
            NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        )
    }

    /// Configure the amount of space added around the content of the item to adjust its final
    /// size after its position is computed.
    @warn_unqualified_access
    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutGroup {
        valueModifier(insets, keyPath: \.contentInsets)
    }
}

extension LayoutGroup {

    // MARK: - Edge Spacing

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    @warn_unqualified_access
    public func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutGroup {
        return self.edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    @warn_unqualified_access
    public func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutGroup {
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
    ) -> LayoutGroup {
        return self.edgeSpacing(
            NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        )
    }

    /// Configure the amount of space added around the boundaries of the item between other items
    /// and this item's container.
    @warn_unqualified_access
    public func edgeSpacing(_ edgeSpacing: NSCollectionLayoutEdgeSpacing) -> LayoutGroup {
        valueModifier(edgeSpacing, keyPath: \.edgeSpacing)
    }
}
