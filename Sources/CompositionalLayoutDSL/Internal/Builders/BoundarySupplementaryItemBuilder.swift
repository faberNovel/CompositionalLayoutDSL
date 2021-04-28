//
//  BoundarySupplementaryItemBuilder.swift
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

internal protocol BuildableBoundarySupplementaryItem: BuildableSupplementaryItem {
    func makeBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem
}

extension BuildableBoundarySupplementaryItem {
    func makeSupplementaryItem() -> NSCollectionLayoutSupplementaryItem {
        makeBoundarySupplementaryItem()
    }
}

internal enum BoundarySupplementaryItemBuilder {
    static func make(
        from layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem
    ) -> NSCollectionLayoutBoundarySupplementaryItem {
        guard let buildable = getBuildableBoundarySupplementaryItem(from: layoutBoundarySupplementaryItem) else {
            // swiftlint:disable:next line_length
            fatalError("Unable to convert the given LayoutBoundarySupplementaryItem to NSCollectionLayoutBoundarySupplementaryItem")
        }
        return buildable.makeBoundarySupplementaryItem()
    }

    private static func getBuildableBoundarySupplementaryItem(
        from layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem
    ) -> BuildableBoundarySupplementaryItem? {
        var currentBoundarySupplementaryItem = layoutBoundarySupplementaryItem
        while !(currentBoundarySupplementaryItem is BuildableBoundarySupplementaryItem) {
            currentBoundarySupplementaryItem = currentBoundarySupplementaryItem.layoutBoundarySupplementaryItem
        }
        return currentBoundarySupplementaryItem as? BuildableBoundarySupplementaryItem
    }
}
