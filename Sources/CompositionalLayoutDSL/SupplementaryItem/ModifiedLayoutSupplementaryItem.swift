//
//  ModifiedLayoutSupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

protocol BuildableLayoutSupplementaryItemModifier {
    func collectionLayoutSupplementaryItem(
        layoutSupplementaryItem: LayoutSupplementaryItem
    ) -> NSCollectionLayoutSupplementaryItem
}

struct ModifiedLayoutSupplementaryItem: LayoutSupplementaryItem, BuildableSupplementaryItem {
    let supplementaryItem: LayoutSupplementaryItem
    let modifier: BuildableLayoutSupplementaryItemModifier

    var layoutSupplementaryItem: LayoutSupplementaryItem { self }

    func makeSupplementaryItem() -> NSCollectionLayoutSupplementaryItem {
        return modifier.collectionLayoutSupplementaryItem(layoutSupplementaryItem: supplementaryItem)
    }
}

extension LayoutSupplementaryItem {
    func modifier(_ modifier: BuildableLayoutSupplementaryItemModifier) -> LayoutSupplementaryItem {
        ModifiedLayoutSupplementaryItem(supplementaryItem: self, modifier: modifier)
    }
}
