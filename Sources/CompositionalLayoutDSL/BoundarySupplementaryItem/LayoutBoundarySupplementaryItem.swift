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
}
