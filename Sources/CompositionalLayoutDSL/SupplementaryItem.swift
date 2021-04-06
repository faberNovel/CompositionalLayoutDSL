//
//  SupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 06/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import Foundation
import UIKit

public struct SupplementaryItem {
    public var width: NSCollectionLayoutDimension
    public var height: NSCollectionLayoutDimension
    public var contentInsets: NSDirectionalEdgeInsets = .zero
    public var edgeSpacing: NSCollectionLayoutEdgeSpacing?

    var elementKind: String = ""
    var containerAnchor = NSCollectionLayoutAnchor(edges: [])
    var itemAnchor: NSCollectionLayoutAnchor?
    var zIndex: Int = 0

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                height: NSCollectionLayoutDimension = .fractionalHeight(1.0)) {
        self.width = width
        self.height = height
    }

    public init(size: NSCollectionLayoutSize) {
        self.width = size.widthDimension
        self.height = size.heightDimension
    }

    public func elementKind(_ kind: String) -> Self {
        with(self) { $0.elementKind = elementKind }
    }

    public func containerAnchor(_ anchor: NSCollectionLayoutAnchor) -> Self {
        with(self) { $0.containerAnchor = containerAnchor }
    }

    public func itemAnchor(_ anchor: NSCollectionLayoutAnchor) -> Self {
        with(self) { $0.itemAnchor = itemAnchor }
    }
}

extension SupplementaryItem: ItemProperties {}

public struct BoundarySupplementaryItem {
    public var width: NSCollectionLayoutDimension
    public var height: NSCollectionLayoutDimension
    public var contentInsets: NSDirectionalEdgeInsets = .zero
    public var edgeSpacing: NSCollectionLayoutEdgeSpacing?

    var elementKind: String = ""
    var alignment: NSRectAlignment = .none
    var offset: CGPoint = .zero

    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
                height: NSCollectionLayoutDimension = .fractionalHeight(1.0)) {
        self.width = width
        self.height = height
    }

    public init(size: NSCollectionLayoutSize) {
        self.width = size.widthDimension
        self.height = size.heightDimension
    }

    public func elementKind(_ kind: String) -> Self {
        with(self) { $0.elementKind = kind }
    }

    public func alignment(_ alignment: NSRectAlignment) -> Self {
        with(self) { $0.alignment = alignment }
    }

    public func offset(_ offset: CGPoint) -> Self {
        with(self) { $0.offset = offset }
    }

    // TODO: (Pierre Felgines) 24/02/2021 Fill missing sections

    func makeItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
        let item = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: elementKind,
            alignment: alignment,
            absoluteOffset: offset
        )
        return item
    }
}

extension BoundarySupplementaryItem: ItemProperties {}
