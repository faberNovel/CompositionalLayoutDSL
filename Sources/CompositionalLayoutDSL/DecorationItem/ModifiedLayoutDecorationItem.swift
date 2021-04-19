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

extension LayoutDecorationItem {
    func modifier(_ modifier: BuildableLayoutDecorationItemModifier) -> LayoutDecorationItem {
        ModifiedLayoutDecorationItem(decorationItem: self, modifier: modifier)
    }
}
