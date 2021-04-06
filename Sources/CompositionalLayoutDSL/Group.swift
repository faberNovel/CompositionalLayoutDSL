//
//  Group.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation
import UIKit

public struct Group: LayoutItem {

    enum Direction {
        case horizontal
        case vertical
    }

    enum Subitem {
        case list([LayoutItem])
        case repeated(LayoutItem, count: Int)
    }

    let direction: Direction
    let subitems: Subitem

    public var width: NSCollectionLayoutDimension
    public var height: NSCollectionLayoutDimension
    public var contentInsets: NSDirectionalEdgeInsets = .zero
    public var edgeSpacing: NSCollectionLayoutEdgeSpacing?

    var interItemSpacing: NSCollectionLayoutSpacing?

    fileprivate init(direction: Direction,
                     subitems: Subitem,
                     width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                     height: NSCollectionLayoutDimension = .fractionalHeight(1.0)) {
        self.direction = direction
        self.subitems = subitems
        self.width = width
        self.height = height
    }

    fileprivate init(direction: Direction,
                     subitems: Subitem,
                     size: NSCollectionLayoutSize) {
        self.direction = direction
        self.subitems = subitems
        self.width = size.widthDimension
        self.height = size.heightDimension
    }

    public func interItemSpacing(_ spacing: NSCollectionLayoutSpacing?) -> Self {
        return with(self) {
            $0.interItemSpacing = spacing
        }
    }

    public func makeItem() -> NSCollectionLayoutItem {
        return makeGroup()
    }

    func makeGroup() -> NSCollectionLayoutGroup {
        let size = NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
        let group: NSCollectionLayoutGroup
        switch direction {
        case .horizontal:
            switch subitems {
            case let .list(items):
                group = .horizontal(
                    layoutSize: size,
                    subitems: items.map { $0.makeItem() }
                )
            case let .repeated(item, count: count):
                group = .horizontal(
                    layoutSize: size,
                    subitem: item.makeItem(),
                    count: count
                )
            }
        case .vertical:
            switch subitems {
            case let .list(items):
                group = .vertical(
                    layoutSize: size,
                    subitems: items.map { $0.makeItem() }
                )
            case let .repeated(item, count: count):
                group = .vertical(
                    layoutSize: size,
                    subitem: item.makeItem(),
                    count: count
                )
            }
        }
        group.contentInsets = contentInsets
        group.edgeSpacing = edgeSpacing
        group.interItemSpacing = interItemSpacing
        return group
    }
}

public func HGroup(size: NSCollectionLayoutSize,
                   @ItemBuilder items: () -> [LayoutItem]) -> Group {
    return Group(
        direction: .horizontal,
        subitems: .list(items()),
        size: size
    )
}

public func HGroup(size: NSCollectionLayoutSize,
                   count: Int,
                   item: () -> LayoutItem) -> Group {
    return Group(
        direction: .horizontal,
        subitems: .repeated(item(), count: count),
        size: size
    )
}

public func HGroup(width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                   height: NSCollectionLayoutDimension = .fractionalHeight(1.0),
                   @ItemBuilder items: () -> [LayoutItem]) -> Group {
    return Group(
        direction: .horizontal,
        subitems: .list(items()),
        size: NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
    )
}

public func HGroup(width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                   height: NSCollectionLayoutDimension = .fractionalHeight(1.0),
                   count: Int,
                   item: () -> LayoutItem) -> Group {
    return Group(
        direction: .horizontal,
        subitems: .repeated(item(), count: count),
        size: NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
    )
}

public func VGroup(size: NSCollectionLayoutSize,
                   @ItemBuilder items: () -> [LayoutItem]) -> Group {
    return Group(
        direction: .vertical,
        subitems: .list(items()),
        size: size
    )
}

public func VGroup(size: NSCollectionLayoutSize,
                   count: Int,
                   item: () -> LayoutItem) -> Group {
    return Group(
        direction: .vertical,
        subitems: .repeated(item(), count: count),
        size: size
    )
}

public func VGroup(width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                   height: NSCollectionLayoutDimension = .fractionalHeight(1.0),
                   @ItemBuilder items: () -> [LayoutItem]) -> Group {
    return Group(
        direction: .vertical,
        subitems: .list(items()),
        size: NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
    )
}

public func VGroup(width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                   height: NSCollectionLayoutDimension = .fractionalHeight(1.0),
                   count: Int,
                   item: () -> LayoutItem) -> Group {
    return Group(
        direction: .vertical,
        subitems: .repeated(item(), count: count),
        size: NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
    )
}
