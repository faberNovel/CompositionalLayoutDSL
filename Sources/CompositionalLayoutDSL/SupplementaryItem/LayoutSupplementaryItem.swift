//
//  LayoutSupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

// MARK: - CollectionLayoutSupplementaryItemConvertible

public protocol CollectionLayoutSupplementaryItemConvertible {
    var collectionLayoutSupplementaryItem: NSCollectionLayoutSupplementaryItem { get }
}

extension NSCollectionLayoutSupplementaryItem: CollectionLayoutSupplementaryItemConvertible {
    public var collectionLayoutSupplementaryItem: NSCollectionLayoutSupplementaryItem { self }
}

// MARK: - LayoutSupplementaryItem

public protocol LayoutSupplementaryItem: LayoutItem, CollectionLayoutSupplementaryItemConvertible {
    var layoutSupplementaryItem: CollectionLayoutSupplementaryItemConvertible { get }
}

public extension LayoutSupplementaryItem {

    // MARK: - LayoutItem

    var layoutItem: CollectionLayoutItemConvertible {
        layoutSupplementaryItem.collectionLayoutSupplementaryItem
    }

    // MARK: - CollectionLayoutSupplementaryItemConvertible

    var collectionLayoutSupplementaryItem: NSCollectionLayoutSupplementaryItem {
        layoutSupplementaryItem.collectionLayoutSupplementaryItem
    }
}

extension NSCollectionLayoutSupplementaryItem: LayoutSupplementaryItem {
    public var layoutSupplementaryItem: CollectionLayoutSupplementaryItemConvertible { self }
}

public extension LayoutSupplementaryItem {

    // MARK: - Mutable properties

    func zIndex(zIndex: Int) -> LayoutSupplementaryItem {
        with(collectionLayoutSupplementaryItem) { $0.zIndex = zIndex }
    }
}

// TODO: (Alexandre Podlewski) 07/04/2021 Refactor with LayoutItem
public extension LayoutSupplementaryItem {

    func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutSupplementaryItem {
        return contentInsets(
            top: insets.top,
            leading: insets.leading,
            bottom: insets.bottom,
            trailing: insets.trailing
        )
    }

    func contentInsets(value: CGFloat) -> LayoutSupplementaryItem {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutSupplementaryItem {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutSupplementaryItem {
        return with(collectionLayoutSupplementaryItem) {
            $0.contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        }
    }

    func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutSupplementaryItem {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutSupplementaryItem {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutSupplementaryItem {
        return with(collectionLayoutSupplementaryItem) {
            $0.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: leading,
                top: top,
                trailing: trailing,
                bottom: bottom
            )
        }
    }
}
