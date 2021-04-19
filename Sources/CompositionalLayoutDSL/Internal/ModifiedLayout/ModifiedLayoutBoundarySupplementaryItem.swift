//
//  ModifiedLayoutBoundarySupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

protocol BuildableLayoutBoundarySupplementaryItemModifier {
    func collectionLayoutBoundarySupplementaryItem(
        layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem
    ) -> NSCollectionLayoutBoundarySupplementaryItem
}

struct ModifiedLayoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem, BuildableBoundarySupplementaryItem {
    let boundarysupplementaryItem: LayoutBoundarySupplementaryItem
    let modifier: BuildableLayoutBoundarySupplementaryItemModifier

    var layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem { self }

    func makeBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return modifier.collectionLayoutBoundarySupplementaryItem(
            layoutBoundarySupplementaryItem: boundarysupplementaryItem
        )
    }
}

struct ValueModifiedLayoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem,
                                                     BuildableBoundarySupplementaryItem {
    let boundarySupplementaryItem: LayoutBoundarySupplementaryItem
    let valueModifier: (inout NSCollectionLayoutBoundarySupplementaryItem) -> Void

    var layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem { self }

    func makeBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        var collectionLayoutBoundarySupplementaryItem = BoundarySupplementaryItemBuilder
            .make(from: boundarySupplementaryItem)
        valueModifier(&collectionLayoutBoundarySupplementaryItem)
        return collectionLayoutBoundarySupplementaryItem
    }
}

extension LayoutBoundarySupplementaryItem {
    func modifier(_ modifier: BuildableLayoutBoundarySupplementaryItemModifier) -> LayoutBoundarySupplementaryItem {
        ModifiedLayoutBoundarySupplementaryItem(boundarysupplementaryItem: self, modifier: modifier)
    }

    func valueModifier<T>(
        _ value: T,
        keyPath: WritableKeyPath<NSCollectionLayoutBoundarySupplementaryItem, T>
    ) -> LayoutBoundarySupplementaryItem {
        ValueModifiedLayoutBoundarySupplementaryItem(boundarySupplementaryItem: self) {
            $0[keyPath: keyPath] = value
        }
    }
}
