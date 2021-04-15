//
//  LayoutDecorationItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutDecorationItem: LayoutItem {
    var layoutDecorationItem: LayoutDecorationItem { get }
    func _makeDecorationItem() -> NSCollectionLayoutDecorationItem
}

public extension LayoutDecorationItem {

    func _makeDecorationItem() -> NSCollectionLayoutDecorationItem {
        layoutDecorationItem._makeDecorationItem()
    }

    // MARK: - LayoutItem

    var layoutItem: LayoutItem { self }
    func _makeItem() -> NSCollectionLayoutItem { _makeDecorationItem() }
}

extension HasDecorationItemProperties {
    public func zIndex(zIndex: Int) -> Self {
        with(self) { $0.zIndex = zIndex }
    }
}
