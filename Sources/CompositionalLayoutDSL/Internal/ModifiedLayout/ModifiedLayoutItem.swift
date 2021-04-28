//
//  ModifiedLayoutItem.swift
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

struct ValueModifiedLayoutItem: LayoutItem, BuildableItem {
    let item: LayoutItem
    let valueModifier: (inout NSCollectionLayoutItem) -> Void

    var layoutItem: LayoutItem { self }

    func makeItem() -> NSCollectionLayoutItem {
        var collectionLayoutItem = ItemBuilder.make(from: item)
        valueModifier(&collectionLayoutItem)
        return collectionLayoutItem
    }
}

extension LayoutItem {
    func valueModifier<T>(_ value: T, keyPath: WritableKeyPath<NSCollectionLayoutItem, T>) -> LayoutItem {
        ValueModifiedLayoutItem(item: self) { $0[keyPath: keyPath] = value }
    }
}
