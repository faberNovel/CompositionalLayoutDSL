//
//  EdgeSpacingModifier.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

struct EdgeSpacingModifier {
    let edgeSpacing: NSCollectionLayoutEdgeSpacing
}

extension EdgeSpacingModifier: BuildableLayoutItemModifier {
    func collectionLayoutItem(layoutItem: LayoutItem) -> NSCollectionLayoutItem {
        let collectionLayoutItem = ItemBuilder.make(from: layoutItem)
        collectionLayoutItem.edgeSpacing = edgeSpacing
        return collectionLayoutItem
    }
}

extension EdgeSpacingModifier: BuildableLayoutSupplementaryItemModifier {
    func collectionLayoutSupplementaryItem(
        layoutSupplementaryItem: LayoutSupplementaryItem
    ) -> NSCollectionLayoutSupplementaryItem {
        let collectionLayoutItem = SupplementaryItemBuilder.make(from: layoutSupplementaryItem)
        collectionLayoutItem.edgeSpacing = edgeSpacing
        return collectionLayoutItem
    }
}

extension EdgeSpacingModifier: BuildableLayoutBoundarySupplementaryItemModifier {
    func collectionLayoutBoundarySupplementaryItem(
        layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem
    ) -> NSCollectionLayoutBoundarySupplementaryItem {
        let collectionLayoutItem = BoundarySupplementaryItemBuilder.make(
            from: layoutBoundarySupplementaryItem
        )
        collectionLayoutItem.edgeSpacing = edgeSpacing
        return collectionLayoutItem
    }
}

extension EdgeSpacingModifier: BuildableLayoutDecorationItemModifier {
    func collectionLayoutDecorationItem(
        layoutDecorationItem: LayoutDecorationItem
    ) -> NSCollectionLayoutDecorationItem {
        let collectionLayoutItem = DecorationItemBuilder.make(from: layoutDecorationItem)
        collectionLayoutItem.edgeSpacing = edgeSpacing
        return collectionLayoutItem
    }
}

extension EdgeSpacingModifier: BuildableLayoutGroupModifier {
    func collectionLayoutGroup(layoutGroup: LayoutGroup) -> NSCollectionLayoutGroup {
        let collectionLayoutGroup = GroupBuilder.make(from: layoutGroup)
        collectionLayoutGroup.edgeSpacing = edgeSpacing
        return collectionLayoutGroup
    }
}
