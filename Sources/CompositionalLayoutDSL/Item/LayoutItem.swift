//
//  LayoutItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

// MARK: - CollectionLayoutItemConvertible

public protocol CollectionLayoutItemConvertible {
    var collectionLayoutItem: NSCollectionLayoutItem { get }
}

extension NSCollectionLayoutItem: CollectionLayoutItemConvertible {
    public var collectionLayoutItem: NSCollectionLayoutItem { self }
}

// MARK: - LayoutItem

public protocol LayoutItem: CollectionLayoutItemConvertible {
    var layoutItem: CollectionLayoutItemConvertible { get }
}

public extension LayoutItem {

    // MARK: - CollectionLayoutItemConvertible

    var collectionLayoutItem: NSCollectionLayoutItem { layoutItem.collectionLayoutItem }
}

extension NSCollectionLayoutItem: LayoutItem {
    public var layoutItem: CollectionLayoutItemConvertible { self }
}

public extension LayoutItem {

    // MARK: - Mutable properties

    func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutItem {
        return contentInsets(
            top: insets.top,
            leading: insets.leading,
            bottom: insets.bottom,
            trailing: insets.trailing
        )
    }

    func contentInsets(value: CGFloat) -> LayoutItem {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutItem {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func contentInsets(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> LayoutItem {
        return with(layoutItem.collectionLayoutItem) {
            $0.contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        }
    }

    func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutItem {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutItem {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutItem {
        return with(layoutItem.collectionLayoutItem) {
            $0.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: leading,
                top: top,
                trailing: trailing,
                bottom: bottom
            )
        }
    }
}
