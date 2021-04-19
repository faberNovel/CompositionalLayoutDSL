//
//  LayoutGroup.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutGroup: LayoutItem {
    var layoutGroup: LayoutGroup { get }
}

public extension LayoutGroup {

    // MARK: - LayoutItem

    var layoutItem: LayoutItem { layoutGroup }
}

extension LayoutGroup {

    // MARK: - Group Mutable properties

    public func supplementaryItems(
        @LayoutSupplementaryItemBuilder _ supplementaryItems: () -> [LayoutSupplementaryItem]
    ) -> LayoutGroup {
        let supplementaryItems = supplementaryItems().map(SupplementaryItemBuilder.make(from:))
        return valueModifier { $0.supplementaryItems.append(contentsOf: supplementaryItems) }
    }

    public func interItemSpacing(_ interItemSpacing: NSCollectionLayoutSpacing?) -> LayoutGroup {
        valueModifier(interItemSpacing, keyPath: \.interItemSpacing)
    }
}

extension LayoutGroup {

    // MARK: - Content Insets

    public func contentInsets(value: CGFloat) -> LayoutGroup {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    public func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutGroup {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    public func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutGroup {
        contentInsets(NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }

    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutGroup {
        valueModifier(insets, keyPath: \.contentInsets)
    }
}

extension LayoutGroup {

    // MARK: - Edge Spacing

    public func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutGroup {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    public func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutGroup {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    public func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutGroup {
        edgeSpacing(
            NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        )
    }

    public func edgeSpacing(_ edgeSpacing: NSCollectionLayoutEdgeSpacing) -> LayoutGroup {
        valueModifier(edgeSpacing, keyPath: \.edgeSpacing)
    }
}
