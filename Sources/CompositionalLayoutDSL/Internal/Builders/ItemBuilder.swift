//
//  ItemBuilder.swift
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

internal protocol BuildableItem {
    func makeItem() -> NSCollectionLayoutItem
}

internal enum ItemBuilder {
    static func make(from layoutItem: LayoutItem) -> NSCollectionLayoutItem {
        guard let buildableItem = getBuildableItem(from: layoutItem) else {
            fatalError("Unable to convert the given LayoutItem to NSCollectionLayoutItem")
        }
        return buildableItem.makeItem()
    }

    private static func getBuildableItem(from layoutItem: LayoutItem) -> BuildableItem? {
        var currentItem = layoutItem
        while !(currentItem is BuildableItem) {
            currentItem = currentItem.layoutItem
        }
        return currentItem as? BuildableItem
    }
}
