//
//  LayoutGroup.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

// MARK: - CollectionLayoutGroupConvertible

public protocol CollectionLayoutGroupConvertible {
    var collectionLayoutGroup: NSCollectionLayoutGroup { get }
}

extension NSCollectionLayoutGroup: CollectionLayoutGroupConvertible {
    public var collectionLayoutGroup: NSCollectionLayoutGroup { self }
}

// MARK: - LayoutGroup

public protocol LayoutGroup: LayoutItem, CollectionLayoutGroupConvertible {
    var layoutGroup: CollectionLayoutGroupConvertible { get }
}

public extension LayoutGroup {

    // MARK: - LayoutItem

    var layoutItem: CollectionLayoutItemConvertible {
        layoutGroup.collectionLayoutGroup
    }

    // MARK: - CollectionLayoutGroupConvertible

    var collectionLayoutGroup: NSCollectionLayoutGroup { layoutGroup.collectionLayoutGroup }
}

extension NSCollectionLayoutGroup: LayoutGroup {
    public var layoutGroup: CollectionLayoutGroupConvertible { self }
}

// MARK: - Mutable Properties

public extension LayoutGroup {

    func supplementaryItems(
        @SupplementaryItemBuilder _ supplementaryItems: () -> [LayoutSupplementaryItem]
    ) -> LayoutGroup {
        with(collectionLayoutGroup) {
            $0.supplementaryItems.append(
                contentsOf: supplementaryItems().map(\.collectionLayoutSupplementaryItem)
            )
        }
    }

    func interItemSpacing(_ interItemSpacing: NSCollectionLayoutSpacing?) -> LayoutGroup {
        with(collectionLayoutGroup) { $0.interItemSpacing = interItemSpacing }
    }
}

// TODO: (Alexandre Podlewski) 07/04/2021 Refactor with LayoutItem
public extension LayoutGroup {
    func contentInsets(value: CGFloat) -> LayoutGroup {
        return contentInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    func contentInsets(horizontal: CGFloat = 0, vertical: CGFloat = 0) -> LayoutGroup {
        return contentInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func contentInsets(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> LayoutGroup {
        return with(collectionLayoutGroup) {
            $0.contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        }
    }

    func edgeSpacing(value: NSCollectionLayoutSpacing?) -> LayoutGroup {
        return edgeSpacing(top: value, leading: value, bottom: value, trailing: value)
    }

    func edgeSpacing(
        horizontal: NSCollectionLayoutSpacing? = nil,
        vertical: NSCollectionLayoutSpacing? = nil
    ) -> LayoutGroup {
        return edgeSpacing(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    func edgeSpacing(
        top: NSCollectionLayoutSpacing? = nil,
        leading: NSCollectionLayoutSpacing? = nil,
        bottom: NSCollectionLayoutSpacing? = nil,
        trailing: NSCollectionLayoutSpacing? = nil
    ) -> LayoutGroup {
        return with(collectionLayoutGroup) {
            $0.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: leading, top: top, trailing: trailing, bottom: bottom)
        }
    }
}
