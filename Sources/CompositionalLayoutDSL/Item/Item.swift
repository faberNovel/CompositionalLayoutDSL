//
//  Item.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct Item: LayoutItem, ResizableItem {

    private var widthDimension: NSCollectionLayoutDimension
    private var heightDimension: NSCollectionLayoutDimension
    private var supplementaryItems: [CollectionLayoutSupplementaryItemConvertible]

    // MARK: - Life cycle

    public init(width: NSCollectionLayoutDimension,
                height: NSCollectionLayoutDimension,
                @SupplementaryItemBuilder supplementaryItems: () -> [CollectionLayoutSupplementaryItemConvertible]) {
        self.widthDimension = width
        self.heightDimension = height
        self.supplementaryItems = supplementaryItems()
    }

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1)) {
        self.widthDimension = width
        self.heightDimension = height
        self.supplementaryItems = []
    }

    public init(size: NSCollectionLayoutSize) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.supplementaryItems = []
    }

    public init(@SupplementaryItemBuilder supplementaryItems: () -> [CollectionLayoutSupplementaryItemConvertible]) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), supplementaryItems: supplementaryItems)
    }

    public init() {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), supplementaryItems: {})
    }

    // MARK: - ResizableItem

    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }

    // MARK: - LayoutItem

    public var layoutItem: CollectionLayoutItemConvertible {
        return NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension),
            supplementaryItems: supplementaryItems.map(\.collectionLayoutSupplementaryItem)
        )
    }
}
