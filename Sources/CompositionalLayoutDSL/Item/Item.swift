//
//  Item.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct Item: LayoutItem, ResizableItem {

    internal var widthDimension: NSCollectionLayoutDimension
    internal var heightDimension: NSCollectionLayoutDimension
    private var supplementaryItems: [LayoutSupplementaryItem]

    // MARK: - Life cycle

    public init(width: NSCollectionLayoutDimension,
                height: NSCollectionLayoutDimension,
                @LayoutSupplementaryItemBuilder supplementaryItems: () -> [LayoutSupplementaryItem]) {
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

    public init(@LayoutSupplementaryItemBuilder supplementaryItems: () -> [LayoutSupplementaryItem]) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), supplementaryItems: supplementaryItems)
    }

    public init() {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), supplementaryItems: {})
    }

    // MARK: - LayoutItem

    public var layoutItem: LayoutItem {
        return self
    }
}

extension Item: HasResizableProperties {}

extension Item: BuildableItem {
    func makeItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension),
            supplementaryItems: supplementaryItems.map(SupplementaryItemBuilder.make(from:))
        )
        return item
    }
}
