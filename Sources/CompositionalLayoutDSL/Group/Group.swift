//
//  Group.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

internal protocol InternalResizableItem: ResizableItem {
    var widthDimension: NSCollectionLayoutDimension { get set }
    var heightDimension: NSCollectionLayoutDimension { get set }
}

extension InternalResizableItem {

    // MARK: - ResizableItem

    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}

public struct HGroup: LayoutGroup, ResizableItem {

    enum SubItems {
        case list([CollectionLayoutItemConvertible])
        case repeated(CollectionLayoutItemConvertible, count: Int)
    }

    internal var widthDimension: NSCollectionLayoutDimension
    internal var heightDimension: NSCollectionLayoutDimension
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
        makeGroup()
    }

    // MARK: - Private

    private func makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        switch subItems {
        case let .list(items):
            return .horizontal(layoutSize: size, subitems: items.map(\.collectionLayoutItem))
        case let .repeated(item, count):
            return .horizontal(layoutSize: size, subitem: item.collectionLayoutItem, count: count)
        }
    }
}

extension HGroup: InternalResizableItem {}

public struct VGroup: LayoutGroup, ResizableItem {

    private enum SubItems {
        case list([CollectionLayoutItemConvertible])
        case repeated(CollectionLayoutItemConvertible, count: Int)
    }

    internal var widthDimension: NSCollectionLayoutDimension
    internal var heightDimension: NSCollectionLayoutDimension
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
        makeGroup()
    }

    // MARK: - Private

    private func makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        switch subItems {
        case let .list(items):
            return .vertical(layoutSize: size, subitems: items.map(\.collectionLayoutItem))
        case let .repeated(item, count):
            return .vertical(layoutSize: size, subitem: item.collectionLayoutItem, count: count)
        }
    }
}

extension VGroup: InternalResizableItem {}
