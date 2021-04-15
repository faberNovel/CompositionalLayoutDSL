//
//  LayoutItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutItem: ContentInsetable, EdgeSpacable {
    var layoutItem: LayoutItem { get }
    func _makeItem() -> NSCollectionLayoutItem
}

public extension LayoutItem {
    func _makeItem() -> NSCollectionLayoutItem {
        layoutItem._makeItem()
    }
}

extension HasResizableProperties {
    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}
