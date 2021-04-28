//
//  VGroup.swift
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

/// A container for a set of items that lays out the items vertically.
public struct VGroup: LayoutGroup, ResizableItem {

    private enum SubItems {
        case list([LayoutItem])
        case repeated(LayoutItem, count: Int)
    }

    private var widthDimension: NSCollectionLayoutDimension
    private var heightDimension: NSCollectionLayoutDimension
    private var subItems: SubItems

    // MARK: - Life cycle

    /// Creates a group of the specified size, containing an array of items arranged in a vertical line.
    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                @LayoutItemBuilder subItems: () -> [LayoutItem]) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .list(subItems())
    }

    /// Creates a group of the specified size, containing an array of items arranged in a vertical line.
    public init(size: NSCollectionLayoutSize,
                @LayoutItemBuilder subItems: () -> [LayoutItem]) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .list(subItems())
    }

    /// Creates a group of the specified size, containing an array of equally sized items arranged
    /// in a horizontal line up to the number specified by count.
    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                count: Int,
                subItem: () -> LayoutItem) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .repeated(subItem(), count: count)
    }

    /// Creates a group of the specified size, containing an array of equally sized items arranged
    /// in a horizontal line up to the number specified by count.
    public init(size: NSCollectionLayoutSize,
                count: Int,
                subItem: () -> LayoutItem) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .repeated(subItem(), count: count)
    }

    /// Creates a group containing an array of items arranged in a vertical line.
    public init(@LayoutItemBuilder subItems: () -> [LayoutItem]) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), subItems: subItems)
    }

    // MARK: - LayoutGroup

    public var layoutGroup: LayoutGroup {
        return self
    }

    // MARK: - ResizableItem

    /// Configure the width of the group
    ///
    /// The default value is `.fractionalWidth(1.0)`
    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    /// Configure the height of the group
    ///
    /// The default value is `.fractionalHeight(1.0)`
    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}

extension VGroup: BuildableGroup {
    func makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        let group: NSCollectionLayoutGroup
        switch subItems {
        case let .list(items):
            group = NSCollectionLayoutGroup.vertical(
                layoutSize: size,
                subitems: items.map(ItemBuilder.make(from:))
            )
        case let .repeated(item, count):
            group = NSCollectionLayoutGroup.vertical(
                layoutSize: size,
                subitem: ItemBuilder.make(from: item),
                count: count
            )
        }
        return group
    }
}
