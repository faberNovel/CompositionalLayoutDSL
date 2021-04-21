//
//  SupplementaryItemBuilder.swift
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

internal protocol BuildableSupplementaryItem: BuildableItem {
    func makeSupplementaryItem() -> NSCollectionLayoutSupplementaryItem
}

extension BuildableSupplementaryItem {
    func makeItem() -> NSCollectionLayoutItem {
        makeSupplementaryItem()
    }
}

internal enum SupplementaryItemBuilder {
    static func make(
        from layoutSupplementaryItem: LayoutSupplementaryItem
    ) -> NSCollectionLayoutSupplementaryItem {
        guard let buildable = getBuildableSupplementaryItem(from: layoutSupplementaryItem) else {
            fatalError("Unable to convert the given LayoutSupplementaryItem to NSCollectionLayoutSupplementaryItem")
        }
        return buildable.makeSupplementaryItem()
    }

    private static func getBuildableSupplementaryItem(
        from layoutSupplementaryItem: LayoutSupplementaryItem
    ) -> BuildableSupplementaryItem? {
        var currentSupplementaryItem = layoutSupplementaryItem
        while !(currentSupplementaryItem is BuildableSupplementaryItem) {
            currentSupplementaryItem = currentSupplementaryItem.layoutSupplementaryItem
        }
        return currentSupplementaryItem as? BuildableSupplementaryItem
    }
}
