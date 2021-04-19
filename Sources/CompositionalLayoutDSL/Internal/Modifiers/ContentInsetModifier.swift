//
//  ContentInsetModifier.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 19/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

struct ContentInsetModifier {
    let insets: NSDirectionalEdgeInsets
}

extension ContentInsetModifier: BuildableLayoutItemModifier {
    func collectionLayoutItem(layoutItem: LayoutItem) -> NSCollectionLayoutItem {
        let collectionLayoutItem = ItemBuilder.make(from: layoutItem)
        collectionLayoutItem.contentInsets = insets
        return collectionLayoutItem
    }
}

extension ContentInsetModifier: BuildableLayoutSupplementaryItemModifier {
    func collectionLayoutSupplementaryItem(
        layoutSupplementaryItem: LayoutSupplementaryItem
    ) -> NSCollectionLayoutSupplementaryItem {
        let collectionLayoutItem = SupplementaryItemBuilder.make(from: layoutSupplementaryItem)
        collectionLayoutItem.contentInsets = insets
        return collectionLayoutItem
    }
}

extension ContentInsetModifier: BuildableLayoutBoundarySupplementaryItemModifier {
    func collectionLayoutBoundarySupplementaryItem(
        layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem
    ) -> NSCollectionLayoutBoundarySupplementaryItem {
        let collectionLayoutItem = BoundarySupplementaryItemBuilder.make(
            from: layoutBoundarySupplementaryItem
        )
        collectionLayoutItem.contentInsets = insets
        return collectionLayoutItem
    }
}

extension ContentInsetModifier: BuildableLayoutDecorationItemModifier {
    func collectionLayoutDecorationItem(
        layoutDecorationItem: LayoutDecorationItem
    ) -> NSCollectionLayoutDecorationItem {
        let collectionLayoutItem = DecorationItemBuilder.make(from: layoutDecorationItem)
        collectionLayoutItem.contentInsets = insets
        return collectionLayoutItem
    }
}

extension ContentInsetModifier: BuildableLayoutGroupModifier {
    func collectionLayoutGroup(layoutGroup: LayoutGroup) -> NSCollectionLayoutGroup {
        let collectionLayoutGroup = GroupBuilder.make(from: layoutGroup)
        collectionLayoutGroup.contentInsets = insets
        return collectionLayoutGroup
    }
}

extension ContentInsetModifier: BuildableLayoutSectionModifier {
    func collectionLayoutSection(layoutSection: LayoutSection) -> NSCollectionLayoutSection {
        let collectionLayoutSection = SectionBuilder.make(from: layoutSection)
        collectionLayoutSection.contentInsets = insets
        return collectionLayoutSection
    }
}
