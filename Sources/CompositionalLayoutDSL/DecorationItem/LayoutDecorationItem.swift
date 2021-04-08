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

    func zIndex(zIndex: Int) -> LayoutDecorationItem {
        with(collectionLayoutDecorationItem) { $0.zIndex = zIndex }
    }
}
