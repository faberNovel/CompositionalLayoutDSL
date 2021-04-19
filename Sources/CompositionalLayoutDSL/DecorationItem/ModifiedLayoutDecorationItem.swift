//
//  ModifiedLayoutDecorationItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

protocol BuildableLayoutDecorationItemModifier {
    func collectionLayoutDecorationItem(
        layoutDecorationItem: LayoutDecorationItem
    ) -> NSCollectionLayoutDecorationItem
}

struct ModifiedLayoutDecorationItem: LayoutDecorationItem, BuildableDecorationItem {
    let decorationItem: LayoutDecorationItem
    let modifier: BuildableLayoutDecorationItemModifier

    var layoutDecorationItem: LayoutDecorationItem { self }

    func makeDecorationItem() -> NSCollectionLayoutDecorationItem {
        return modifier.collectionLayoutDecorationItem(layoutDecorationItem: decorationItem)
    }
}

struct ValueModifiedLayoutDecorationItem: LayoutDecorationItem, BuildableDecorationItem {
    let decorationItem: LayoutDecorationItem
    let valueModifier: (inout NSCollectionLayoutDecorationItem) -> Void

    var layoutDecorationItem: LayoutDecorationItem { self }

    func makeDecorationItem() -> NSCollectionLayoutDecorationItem {
        var collectionLayoutDecorationItem = DecorationItemBuilder.make(from: decorationItem)
        valueModifier(&collectionLayoutDecorationItem)
        return collectionLayoutDecorationItem
    }
}

extension LayoutDecorationItem {
    func modifier(_ modifier: BuildableLayoutDecorationItemModifier) -> LayoutDecorationItem {
        ModifiedLayoutDecorationItem(decorationItem: self, modifier: modifier)
    }

    func valueModifier<T>(
        _ value: T,
        keyPath: WritableKeyPath<NSCollectionLayoutDecorationItem, T>
    ) -> LayoutDecorationItem {
        ValueModifiedLayoutDecorationItem(decorationItem: self) { $0[keyPath: keyPath] = value }
    }
}
