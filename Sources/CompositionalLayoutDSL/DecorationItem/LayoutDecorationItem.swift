//
//  LayoutDecorationItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

// MARK: - CollectionLayoutDecorationItemConvertible

public protocol CollectionLayoutDecorationItemConvertible {
    var collectionLayoutDecorationItem: NSCollectionLayoutDecorationItem { get }
}

extension NSCollectionLayoutDecorationItem: CollectionLayoutDecorationItemConvertible {
    public var collectionLayoutDecorationItem: NSCollectionLayoutDecorationItem { self }
}

// MARK: - LayoutDecorationItem

public protocol LayoutDecorationItem: LayoutItem, CollectionLayoutDecorationItemConvertible {
    var layoutDecorationItem: CollectionLayoutDecorationItemConvertible { get }
}

public extension LayoutDecorationItem {

    // MARK: - LayoutItem

    var layoutItem: CollectionLayoutItemConvertible {
        layoutDecorationItem.collectionLayoutDecorationItem
    }

    // MARK: - CollectionLayoutDecorationItemConvertible

    var collectionLayoutDecorationItem: NSCollectionLayoutDecorationItem {
        layoutDecorationItem.collectionLayoutDecorationItem
    }
}

extension NSCollectionLayoutDecorationItem: LayoutDecorationItem {
    public var layoutDecorationItem: CollectionLayoutDecorationItemConvertible { self }
}

public extension LayoutDecorationItem {

    // MARK: - Mutable properties

    // TODO: (Alexandre Podlewski) 08/04/2021 Try factoring that with LayoutSupplementaryItem
    func zIndex(zIndex: Int) -> LayoutDecorationItem {
        with(collectionLayoutDecorationItem) { $0.zIndex = zIndex }
    }
}

// TODO: (Alexandre Podlewski) 07/04/2021 Refactor with LayoutItem
public extension LayoutDecorationItem {

    func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutDecorationItem {
        return contentInsets(
            top: insets.top,
            leading: insets.leading,
            bottom: insets.bottom,
            trailing: insets.trailing
        )
    }

    func contentInsets(value: CGFloat) -> LayoutDecorationItem {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutDecorationItem {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func contentInsets(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> LayoutDecorationItem {
        return with(collectionLayoutDecorationItem) {
            $0.contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        }
    }

    func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutDecorationItem {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutDecorationItem {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutDecorationItem {
        return with(collectionLayoutDecorationItem) {
            $0.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        }
    }
}
