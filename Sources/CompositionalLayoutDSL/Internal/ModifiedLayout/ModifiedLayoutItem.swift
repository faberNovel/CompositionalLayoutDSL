//
//  ModifiedLayoutItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

protocol BuildableLayoutItemModifier {
    func collectionLayoutItem(layoutItem: LayoutItem) -> NSCollectionLayoutItem
}

struct ModifiedLayoutItem: LayoutItem, BuildableItem {
    let item: LayoutItem
    let modifier: BuildableLayoutItemModifier

    var layoutItem: LayoutItem { self }

    func makeItem() -> NSCollectionLayoutItem {
        return modifier.collectionLayoutItem(layoutItem: item)
    }
}

extension LayoutItem {
    func modifier(_ modifier: BuildableLayoutItemModifier) -> LayoutItem {
        ModifiedLayoutItem(item: self, modifier: modifier)
    }
}
