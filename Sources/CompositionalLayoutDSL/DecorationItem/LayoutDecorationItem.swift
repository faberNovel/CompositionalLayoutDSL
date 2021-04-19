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
}

public extension LayoutDecorationItem {
    // MARK: - LayoutItem

    var layoutItem: LayoutItem { self }
}

extension HasDecorationItemProperties {
    public func zIndex(zIndex: Int) -> Self {
        with(self) { $0.zIndex = zIndex }
    }
}
