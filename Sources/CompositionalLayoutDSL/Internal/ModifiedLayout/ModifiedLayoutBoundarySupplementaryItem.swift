//
//  ModifiedLayoutBoundarySupplementaryItem.swift
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

    func valueModifier<T>(
        _ value: T,
        keyPath: WritableKeyPath<NSCollectionLayoutBoundarySupplementaryItem, T>
    ) -> LayoutBoundarySupplementaryItem {
        ValueModifiedLayoutBoundarySupplementaryItem(boundarySupplementaryItem: self) {
            $0[keyPath: keyPath] = value
        }
    }
}
