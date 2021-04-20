//
//  SupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct SupplementaryItem: LayoutSupplementaryItem, ResizableItem {

    public enum AnchorOffset {
        case absolute(CGPoint)
        case fractional(CGPoint)
    }

    private var widthDimension: NSCollectionLayoutDimension
    private var heightDimension: NSCollectionLayoutDimension
    private var elementKind: String

    private var containerAnchor = NSCollectionLayoutAnchor(edges: [.top, .leading])
    private var itemAnchor: NSCollectionLayoutAnchor?

    // MARK: - Life cycle

    public init(widthDimension: NSCollectionLayoutDimension = .fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension = .fractionalHeight(1),
                elementKind: String) {
        self.widthDimension = widthDimension
        self.heightDimension = heightDimension
        self.elementKind = elementKind
    }

    public init(size: NSCollectionLayoutSize,
                elementKind: String) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.elementKind = elementKind
    }

    // MARK: - SupplementaryItem

    /// The anchor between the supplementary item and the container it's attached to.
    ///
    /// The defaults container anchor is attached to top leading
    public func containerAnchor(_ containerAnchor: NSCollectionLayoutAnchor) -> Self {
        with(self) { $0.containerAnchor = containerAnchor }
    }

    /// The anchor between the supplementary item and the container it's attached to.
    ///
    /// The defaults container anchor is attached to top leading
    public func containerAnchor(edges: NSDirectionalRectEdge) -> Self {
        containerAnchor(NSCollectionLayoutAnchor(edges: edges))
    }

    /// The anchor between the supplementary item and the container it's attached to.
    ///
    /// The defaults container anchor is attached to top leading
    public func containerAnchor(edges: NSDirectionalRectEdge, offset: AnchorOffset) -> Self {
        switch offset {
        case let .absolute(point):
            return containerAnchor(NSCollectionLayoutAnchor(edges: edges, absoluteOffset: point))
        case let .fractional(point):
            return containerAnchor(NSCollectionLayoutAnchor(edges: edges, fractionalOffset: point))
        }
    }

    /// The anchor between the supplementary item and the item it's attached to.
    public func itemAnchor(_ itemAnchor: NSCollectionLayoutAnchor?) -> Self {
        with(self) { $0.itemAnchor = itemAnchor }
    }

    /// The anchor between the supplementary item and the item it's attached to.
    public func itemAnchor(edges: NSDirectionalRectEdge) -> Self {
        itemAnchor(NSCollectionLayoutAnchor(edges: edges))
    }

    /// The anchor between the supplementary item and the item it's attached to.
    public func itemAnchor(edges: NSDirectionalRectEdge, offset: AnchorOffset) -> Self {
        switch offset {
        case let .absolute(point):
            return itemAnchor(NSCollectionLayoutAnchor(edges: edges, absoluteOffset: point))
        case let .fractional(point):
            return itemAnchor(NSCollectionLayoutAnchor(edges: edges, fractionalOffset: point))
        }
    }

    // MARK: - LayoutSupplementaryItem

    public var layoutSupplementaryItem: LayoutSupplementaryItem {
        return self
    }

    // MARK: - ResizableItem

    /// Configure the width of the supplementary item
    ///
    /// The default value is `.fractionalWidth(1.0)`
    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    /// Configure the height of the supplementary item
    ///
    /// The default value is `.fractionalHeight(1.0)`
    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}

public extension SupplementaryItem.AnchorOffset {
    static func absolute(x: CGFloat, y: CGFloat) -> SupplementaryItem.AnchorOffset {
        return .absolute(CGPoint(x: x, y: y))
    }

    static func fractional(x: CGFloat, y: CGFloat) -> SupplementaryItem.AnchorOffset {
        return .fractional(CGPoint(x: x, y: y))
    }
}

extension SupplementaryItem: BuildableSupplementaryItem {
    func makeSupplementaryItem() -> NSCollectionLayoutSupplementaryItem {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        let supplementaryItem: NSCollectionLayoutSupplementaryItem
        if let itemAnchor = itemAnchor {
            supplementaryItem = NSCollectionLayoutSupplementaryItem(
                layoutSize: size,
                elementKind: elementKind,
                containerAnchor: containerAnchor,
                itemAnchor: itemAnchor
            )
        } else {
            supplementaryItem = NSCollectionLayoutSupplementaryItem(
                layoutSize: size,
                elementKind: elementKind,
                containerAnchor: containerAnchor
            )
        }
        return supplementaryItem
    }
}
