//
//  ModifiedLayoutSupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

struct ValueModifiedLayoutSupplementaryItem: LayoutSupplementaryItem, BuildableSupplementaryItem {
    let supplementaryItem: LayoutSupplementaryItem
    let valueModifier: (inout NSCollectionLayoutSupplementaryItem) -> Void

    var layoutSupplementaryItem: LayoutSupplementaryItem { self }

    func makeSupplementaryItem() -> NSCollectionLayoutSupplementaryItem {
        var collectionLayoutSupplementaryItem = SupplementaryItemBuilder.make(from: supplementaryItem)
        valueModifier(&collectionLayoutSupplementaryItem)
        return collectionLayoutSupplementaryItem
    }
}

extension LayoutSupplementaryItem {

    func valueModifier<T>(
        _ value: T,
        keyPath: WritableKeyPath<NSCollectionLayoutSupplementaryItem, T>
    ) -> LayoutSupplementaryItem {
        ValueModifiedLayoutSupplementaryItem(supplementaryItem: self) { $0[keyPath: keyPath] = value }
    }
}
