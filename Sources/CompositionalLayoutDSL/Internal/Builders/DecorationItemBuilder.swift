//
//  DecorationItemBuilder.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol BuildableDecorationItem: BuildableItem {
    func makeDecorationItem() -> NSCollectionLayoutDecorationItem
}

extension BuildableDecorationItem {
    func makeItem() -> NSCollectionLayoutItem {
        makeDecorationItem()
    }
}

internal enum DecorationItemBuilder {
    static func make(
        from layoutDecorationItem: LayoutDecorationItem
    ) -> NSCollectionLayoutDecorationItem {
        guard let buildable = getBuildableDecorationItem(from: layoutDecorationItem) else {
            fatalError("Unable to convert the given LayoutDecorationItem to NSCollectionLayoutDecorationItem")
        }
        return buildable.makeDecorationItem()
    }

    private static func getBuildableDecorationItem(
        from layoutDecorationItem: LayoutDecorationItem
    ) -> BuildableDecorationItem? {
        var currentDecorationItem = layoutDecorationItem
        while !(currentDecorationItem is BuildableDecorationItem) {
            currentDecorationItem = currentDecorationItem.layoutDecorationItem
        }
        return currentDecorationItem as? BuildableDecorationItem
    }
}
