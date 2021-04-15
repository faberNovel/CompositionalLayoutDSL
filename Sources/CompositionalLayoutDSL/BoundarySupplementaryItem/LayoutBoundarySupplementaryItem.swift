//
//  LayoutBoundarySupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutBoundarySupplementaryItem: LayoutSupplementaryItem {
    var layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem { get }
    func _makeBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem
}

public extension LayoutBoundarySupplementaryItem {

    func _makeBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        layoutBoundarySupplementaryItem._makeBoundarySupplementaryItem()
    }

    // MARK: - LayoutSupplementaryItem

    var layoutSupplementaryItem: LayoutSupplementaryItem { self }
    func _makeSupplementaryItem() -> NSCollectionLayoutSupplementaryItem { _makeBoundarySupplementaryItem() }
}

extension HasBoundarySupplementaryItemProperties {
    public func extendsBoundary(_ extendsBoundary: Bool) -> Self {
        with(self) { $0.extendsBoundary = extendsBoundary }
    }

    public func pinToVisibleBounds(_ pinToVisibleBounds: Bool) -> Self {
        with(self) { $0.pinToVisibleBounds = pinToVisibleBounds }
    }
}
