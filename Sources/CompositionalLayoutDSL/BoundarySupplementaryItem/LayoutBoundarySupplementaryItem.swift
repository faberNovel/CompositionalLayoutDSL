//
//  LayoutBoundarySupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

// MARK: - CollectionLayoutBoundarySupplementaryItemConvertible

public protocol CollectionLayoutBoundarySupplementaryItemConvertible {
    var collectionLayoutBoundarySupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem { get }
}

extension NSCollectionLayoutBoundarySupplementaryItem: CollectionLayoutBoundarySupplementaryItemConvertible {
    public var collectionLayoutBoundarySupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem { self }
}

// MARK: - LayoutBoundarySupplementaryItem

public protocol LayoutBoundarySupplementaryItem: LayoutSupplementaryItem,
                                          CollectionLayoutBoundarySupplementaryItemConvertible {
    var layoutBoundarySupplementaryItem: CollectionLayoutBoundarySupplementaryItemConvertible { get }
}

public extension LayoutBoundarySupplementaryItem {

    // MARK: - LayoutSupplementaryItem

    var layoutSupplementaryItem: CollectionLayoutSupplementaryItemConvertible {
        layoutBoundarySupplementaryItem.collectionLayoutBoundarySupplementaryItem
    }

    // MARK: - CollectionLayoutBoundarySupplementaryItemConvertible

    var collectionLayoutBoundarySupplementaryItem: NSCollectionLayoutBoundarySupplementaryItem {
        layoutBoundarySupplementaryItem.collectionLayoutBoundarySupplementaryItem
    }
}

extension NSCollectionLayoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem {
    public var layoutBoundarySupplementaryItem: CollectionLayoutBoundarySupplementaryItemConvertible { self }
}

public extension LayoutBoundarySupplementaryItem {

    // MARK: - Mutable properties

    func extendsBoundary(_ extendsBoundary: Bool) -> LayoutBoundarySupplementaryItem {
        with(collectionLayoutBoundarySupplementaryItem) { $0.extendsBoundary = extendsBoundary }
    }

    func pinToVisibleBounds(_ pinToVisibleBounds: Bool) -> LayoutBoundarySupplementaryItem {
        with(collectionLayoutBoundarySupplementaryItem) { $0.pinToVisibleBounds = pinToVisibleBounds }
    }

    // TODO: (Alexandre Podlewski) 08/04/2021 Can this be refactored ?
    func zIndex(zIndex: Int) -> LayoutBoundarySupplementaryItem {
        with(collectionLayoutBoundarySupplementaryItem) { $0.zIndex = zIndex }
    }
}

// TODO: (Alexandre Podlewski) 07/04/2021 Refactor with LayoutItem
public extension LayoutBoundarySupplementaryItem {

    func contentInsets(_ insets: NSDirectionalEdgeInsets) -> LayoutBoundarySupplementaryItem {
        return contentInsets(
            top: insets.top,
            leading: insets.leading,
            bottom: insets.bottom,
            trailing: insets.trailing
        )
    }

    func contentInsets(value: CGFloat) -> LayoutBoundarySupplementaryItem {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutBoundarySupplementaryItem {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func contentInsets(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> LayoutBoundarySupplementaryItem {
        return with(collectionLayoutBoundarySupplementaryItem) {
            $0.contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        }
    }

    func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutBoundarySupplementaryItem {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutBoundarySupplementaryItem {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutBoundarySupplementaryItem {
        return with(collectionLayoutBoundarySupplementaryItem) {
            $0.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        }
    }
}
