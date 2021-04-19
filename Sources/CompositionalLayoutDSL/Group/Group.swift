//
//  Group.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct HGroup: LayoutGroup, ResizableItem {

    enum SubItems {
        case list([LayoutItem])
        case repeated(LayoutItem, count: Int)
    }

    internal var widthDimension: NSCollectionLayoutDimension
    internal var heightDimension: NSCollectionLayoutDimension
    internal var supplementaryItems: [LayoutSupplementaryItem] = []
    internal var interItemSpacing: NSCollectionLayoutSpacing?
    private var subItems: SubItems

    // MARK: - Life cycle

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                @LayoutItemBuilder subItems: () -> [LayoutItem]) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .list(subItems())
    }

    public init(size: NSCollectionLayoutSize,
                @LayoutItemBuilder subItems: () -> [LayoutItem]) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .list(subItems())
    }

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                count: Int,
                subItem: () -> LayoutItem) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .repeated(subItem(), count: count)
    }

    public init(size: NSCollectionLayoutSize,
                count: Int,
                subItem: () -> LayoutItem) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .repeated(subItem(), count: count)
    }

    public init(@LayoutItemBuilder subItems: () -> [LayoutItem]) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), subItems: subItems)
    }

    // MARK: - LayoutGroup

    public var layoutGroup: LayoutGroup {
        return self
    }

    // MARK: - ResizableItem

    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}

extension HGroup: HasGroupProperties {}

public struct VGroup: LayoutGroup, ResizableItem {

    private enum SubItems {
        case list([LayoutItem])
        case repeated(LayoutItem, count: Int)
    }

    internal var widthDimension: NSCollectionLayoutDimension
    internal var heightDimension: NSCollectionLayoutDimension
    internal var supplementaryItems: [LayoutSupplementaryItem] = []
    internal var interItemSpacing: NSCollectionLayoutSpacing?
    private var subItems: SubItems

    // MARK: - Life cycle

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                @LayoutItemBuilder subItems: () -> [LayoutItem]) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .list(subItems())
    }

    public init(size: NSCollectionLayoutSize,
                @LayoutItemBuilder subItems: () -> [LayoutItem]) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .list(subItems())
    }

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                count: Int,
                subItem: () -> LayoutItem) {
        self.widthDimension = width
        self.heightDimension = height
        self.subItems = .repeated(subItem(), count: count)
    }

    public init(size: NSCollectionLayoutSize,
                count: Int,
                subItem: () -> LayoutItem) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.subItems = .repeated(subItem(), count: count)
    }

    public init(@LayoutItemBuilder subItems: () -> [LayoutItem]) {
        self.init(width: .fractionalWidth(1), height: .fractionalHeight(1), subItems: subItems)
    }

    // MARK: - LayoutGroup

    public var layoutGroup: LayoutGroup {
        return self
    }

    // MARK: - ResizableItem

    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}

extension VGroup: HasGroupProperties {}

public struct CustomGroup: LayoutGroup, ResizableItem {

    internal var widthDimension: NSCollectionLayoutDimension
    internal var heightDimension: NSCollectionLayoutDimension
    internal var supplementaryItems: [LayoutSupplementaryItem] = []
    internal var interItemSpacing: NSCollectionLayoutSpacing?
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

    public var layoutGroup: LayoutGroup {
        return self
    }

    // MARK: - ResizableItem

    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}

extension CustomGroup: HasGroupProperties {}

// MARK: - BuildableGroup

extension HGroup: BuildableGroup {
    public func makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        let group: NSCollectionLayoutGroup
        switch subItems {
        case let .list(items):
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: size,
                subitems: items.map(ItemBuilder.make(from:))
            )
        case let .repeated(item, count):
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: size,
                subitem: ItemBuilder.make(from: item),
                count: count
            )
        }
        group.apply(groupPropertiesFrom: self)
        return group
    }
}

extension VGroup: BuildableGroup {
    public func makeGroup() -> NSCollectionLayoutGroup {
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
        group.apply(groupPropertiesFrom: self)
        return group
    }
}

extension CustomGroup: BuildableGroup {
    public func makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        let group = NSCollectionLayoutGroup.custom(layoutSize: size, itemProvider: itemProvider)
        group.apply(groupPropertiesFrom: self)
        return group
    }
}
