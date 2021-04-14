//
//  Group.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct HGroup: LayoutGroup, ResizableItem, HasResizableProperties {

    enum SubItems {
        case list([CollectionLayoutItemConvertible])
        case repeated(CollectionLayoutItemConvertible, count: Int)
    }

    public var widthDimension: NSCollectionLayoutDimension
    public var heightDimension: NSCollectionLayoutDimension
    private var subItems: SubItems

    // MARK: - Life cycle

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                @LayoutItemBuilder subItems: () -> [CollectionLayoutItemConvertible]) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .list(subItems())
    }

    public init(size: NSCollectionLayoutSize,
                @LayoutItemBuilder subItems: () -> [CollectionLayoutItemConvertible]) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .list(subItems())
    }

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                count: Int,
                subItem: () -> CollectionLayoutItemConvertible) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .repeated(subItem(), count: count)
    }

    public init(size: NSCollectionLayoutSize,
                count: Int,
                subItem: () -> CollectionLayoutItemConvertible) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .repeated(subItem(), count: count)
    }

    public init(@LayoutItemBuilder subItems: () -> [CollectionLayoutItemConvertible]) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), subItems: subItems)
    }

    // MARK: - LayoutGroup

    public var layoutGroup: CollectionLayoutGroupConvertible {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        switch subItems {
        case let .list(items):
            return NSCollectionLayoutGroup.horizontal(
                layoutSize: size,
                subitems: items.map(\.collectionLayoutItem)
            )
        case let .repeated(item, count):
            return NSCollectionLayoutGroup.horizontal(
                layoutSize: size,
                subitem: item.collectionLayoutItem,
                count: count
            )
        }
    }
}

public struct VGroup: LayoutGroup, ResizableItem, HasResizableProperties {

    private enum SubItems {
        case list([CollectionLayoutItemConvertible])
        case repeated(CollectionLayoutItemConvertible, count: Int)
    }

    public var widthDimension: NSCollectionLayoutDimension
    public var heightDimension: NSCollectionLayoutDimension
    private var subItems: SubItems

    // MARK: - Life cycle

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                @LayoutItemBuilder subItems: () -> [CollectionLayoutItemConvertible]) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .list(subItems())
    }

    public init(size: NSCollectionLayoutSize,
                @LayoutItemBuilder subItems: () -> [CollectionLayoutItemConvertible]) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .list(subItems())
    }

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                count: Int,
                subItem: () -> CollectionLayoutItemConvertible) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .repeated(subItem(), count: count)
    }

    public init(size: NSCollectionLayoutSize,
                count: Int,
                subItem: () -> CollectionLayoutItemConvertible) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .repeated(subItem(), count: count)
    }

    public init(@LayoutItemBuilder subItems: () -> [CollectionLayoutItemConvertible]) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), subItems: subItems)
    }

    // MARK: - LayoutGroup

    public var layoutGroup: CollectionLayoutGroupConvertible {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        switch subItems {
        case let .list(items):
            return NSCollectionLayoutGroup.vertical(
                layoutSize: size,
                subitems: items.map(\.collectionLayoutItem)
            )
        case let .repeated(item, count):
            return NSCollectionLayoutGroup.vertical(
                layoutSize: size,
                subitem: item.collectionLayoutItem,
                count: count
            )
        }
    }
}

public struct CustomGroup: LayoutGroup, ResizableItem, HasResizableProperties {

    public var widthDimension: NSCollectionLayoutDimension
    public var heightDimension: NSCollectionLayoutDimension
    private let itemProvider: NSCollectionLayoutGroupCustomItemProvider

    // MARK: - Life cycle

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                itemProvider: @escaping NSCollectionLayoutGroupCustomItemProvider) {
        self.widthDimension = width
        self.heightDimension = height
        self.itemProvider = itemProvider
    }

    public init(size: NSCollectionLayoutSize,
                itemProvider: @escaping NSCollectionLayoutGroupCustomItemProvider) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.itemProvider = itemProvider
    }

    public init(itemProvider: @escaping NSCollectionLayoutGroupCustomItemProvider) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), itemProvider: itemProvider)
    }

    // MARK: - LayoutGroup

    public var layoutGroup: CollectionLayoutGroupConvertible {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        return NSCollectionLayoutGroup.custom(layoutSize: size, itemProvider: itemProvider)
    }
}
