//
//  Item.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// The most basic component of a collection view's layout.
public struct Item: LayoutItem, ResizableItem {

    private var widthDimension: NSCollectionLayoutDimension
    private var heightDimension: NSCollectionLayoutDimension
    private var supplementaryItems: [LayoutSupplementaryItem]

    // MARK: - Life cycle

    /// Creates an item of the specified size with an array of supplementary items to attach to the item.
    public init(width: NSCollectionLayoutDimension,
                height: NSCollectionLayoutDimension,
                @LayoutSupplementaryItemBuilder supplementaryItems: () -> [LayoutSupplementaryItem]) {
        self.widthDimension = width
        self.heightDimension = height
        self.supplementaryItems = supplementaryItems()
    }

    /// Creates an item of the specified size
    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1)) {
        self.widthDimension = width
        self.heightDimension = height
        self.supplementaryItems = []
    }

    /// Creates an item of the specified size
    public init(size: NSCollectionLayoutSize) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.supplementaryItems = []
    }

    /// Creates an item with an array of supplementary items to attach to the item.
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

    // MARK: - ResizableItem

    /// Configure the width of the item
    ///
    /// The default value is `.fractionalWidth(1.0)`
    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    /// Configure the height of the item
    ///
    /// The default value is `.fractionalHeight(1.0)`
    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}

extension Item: BuildableItem {
    func makeItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension),
            supplementaryItems: supplementaryItems.map(SupplementaryItemBuilder.make(from:))
        )
        return item
    }
}
