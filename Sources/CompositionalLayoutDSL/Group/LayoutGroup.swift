//
//  LayoutGroup.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public protocol LayoutGroup: LayoutItem {
    var layoutGroup: LayoutGroup { get }
    func makeGroup() -> NSCollectionLayoutGroup
}

public extension LayoutGroup {

    // MARK: - LayoutItem

    var layoutItem: LayoutItem { layoutGroup }
    func makeItem() -> NSCollectionLayoutItem { makeGroup() }
}

extension HasGroupProperties {
    public func supplementaryItems(
        @SupplementaryItemBuilder _ supplementaryItems: () -> [LayoutSupplementaryItem]
    ) -> Self {
        with(self) { $0.supplementaryItems.append(contentsOf: supplementaryItems()) }
    }

    public func interItemSpacing(_ interItemSpacing: NSCollectionLayoutSpacing?) -> Self {
        with(self) { $0.interItemSpacing = interItemSpacing }
    }
}
