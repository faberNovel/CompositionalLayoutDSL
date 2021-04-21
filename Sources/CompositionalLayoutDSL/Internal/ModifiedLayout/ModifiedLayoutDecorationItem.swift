//
//  ModifiedLayoutDecorationItem.swift
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
    func valueModifier<T>(
        _ value: T,
        keyPath: WritableKeyPath<NSCollectionLayoutDecorationItem, T>
    ) -> LayoutDecorationItem {
        ValueModifiedLayoutDecorationItem(decorationItem: self) { $0[keyPath: keyPath] = value }
    }
}
