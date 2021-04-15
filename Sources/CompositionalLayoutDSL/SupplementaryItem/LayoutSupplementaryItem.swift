//
//  LayoutSupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutSupplementaryItem: LayoutItem {
    var layoutSupplementaryItem: LayoutSupplementaryItem { get }
    func _makeSupplementaryItem() -> NSCollectionLayoutSupplementaryItem
}

public extension LayoutSupplementaryItem {

    func _makeSupplementaryItem() -> NSCollectionLayoutItem {
        layoutSupplementaryItem._makeSupplementaryItem()
    }

    // MARK: - LayoutItem

    var layoutItem: LayoutItem { self }
    func _makeItem() -> NSCollectionLayoutItem { _makeSupplementaryItem() }
}

extension HasSupplementaryItemProperties {
    public func zIndex(zIndex: Int) -> Self {
        with(self) { $0.zIndex = zIndex }
    }
}
