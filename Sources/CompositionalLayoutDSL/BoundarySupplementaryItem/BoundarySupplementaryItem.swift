//
//  BoundarySupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct BoundarySupplementaryItem: LayoutBoundarySupplementaryItem, ResizableItem, HasResizableProperties {

    internal var widthDimension: NSCollectionLayoutDimension
    internal var heightDimension: NSCollectionLayoutDimension
    private var elementKind: String

    private var alignment: NSRectAlignment = .top
    private var absoluteOffset: CGPoint = .zero

    // MARK: - Life cycle
    
    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                elementKind: String) {
        self.widthDimension = width
        self.heightDimension = height
        self.elementKind = elementKind
    }

    public init(size: NSCollectionLayoutSize,
                elementKind: String) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.elementKind = elementKind
    }

    // MARK: - BoundarySupplementaryItem

    public func alignment(_ alignment: NSRectAlignment) -> Self {
        with(self) { $0.alignment = alignment }
    }

    public func absoluteOffset(_ absoluteOffset: CGPoint) -> Self {
        with(self) { $0.absoluteOffset = absoluteOffset }
    }

    // MARK: - LayoutBoundarySupplementaryItem

    public var layoutBoundarySupplementaryItem: CollectionLayoutBoundarySupplementaryItemConvertible {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: widthDimension,
                heightDimension: heightDimension
            ),
            elementKind: elementKind,
            alignment: alignment,
            absoluteOffset: absoluteOffset
        )
    }
}
