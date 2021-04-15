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
    internal var contentInsets: NSDirectionalEdgeInsets = .zero
    internal var edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: nil)
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

    public func _makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        let group: NSCollectionLayoutGroup
        switch subItems {
        case let .list(items):
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: size,
                subitems: items.map { $0._makeItem() }
            )
        case let .repeated(item, count):
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: size,
                subitem: item._makeItem(),
                count: count
            )
        }
        group.apply(groupPropertiesFrom: self)
        return group
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
    internal var contentInsets: NSDirectionalEdgeInsets = .zero
    internal var edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: nil)
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

    public func _makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        let group: NSCollectionLayoutGroup
        switch subItems {
        case let .list(items):
            group = NSCollectionLayoutGroup.vertical(
                layoutSize: size,
                subitems: items.map { $0._makeItem() }
            )
        case let .repeated(item, count):
            group = NSCollectionLayoutGroup.vertical(
                layoutSize: size,
                subitem: item._makeItem(),
                count: count
            )
        }
        group.apply(groupPropertiesFrom: self)
        return group
    }
}

extension VGroup: HasGroupProperties {}

public struct CustomGroup: LayoutGroup, ResizableItem {

    internal var widthDimension: NSCollectionLayoutDimension
    internal var heightDimension: NSCollectionLayoutDimension
    internal var contentInsets: NSDirectionalEdgeInsets = .zero
    internal var edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: nil)
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

    public func _makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        let group = NSCollectionLayoutGroup.custom(layoutSize: size, itemProvider: itemProvider)
        group.apply(groupPropertiesFrom: self)
        return group
    }
}

extension CustomGroup: HasGroupProperties {}
