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
