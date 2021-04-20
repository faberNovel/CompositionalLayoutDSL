//
//  BoundarySupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

/// An object used to add headers or footers to a collection view.
public struct BoundarySupplementaryItem: LayoutBoundarySupplementaryItem, ResizableItem {

    private var widthDimension: NSCollectionLayoutDimension
    private var heightDimension: NSCollectionLayoutDimension
    private var elementKind: String

    private var alignment: NSRectAlignment = .top
    private var absoluteOffset: CGPoint = .zero

    // MARK: - Life cycle

    /// Creates a boundary supplementary item of the specified size, with a string to identify the
    /// element kind.
    public init(width: NSCollectionLayoutDimension = .fractionalWidth(1),
                height: NSCollectionLayoutDimension = .fractionalHeight(1),
                elementKind: String) {
        self.widthDimension = width
        self.heightDimension = height
        self.elementKind = elementKind
    }

    /// Creates a boundary supplementary item of the specified size, with a string to identify the
    /// element kind.
    public init(size: NSCollectionLayoutSize,
                elementKind: String) {
        self.widthDimension = size.widthDimension
        self.heightDimension = size.heightDimension
        self.elementKind = elementKind
    }

    // MARK: - BoundarySupplementaryItem

    /// The alignment of the boundary supplementary item relative to the section or layout it's attached to.
    ///
    /// The default value for this property is `NSRectAlignment.top`
    public func alignment(_ alignment: NSRectAlignment) -> Self {
        with(self) { $0.alignment = alignment }
    }

    public func absoluteOffset(_ absoluteOffset: CGPoint) -> Self {
        with(self) { $0.absoluteOffset = absoluteOffset }
    }

    // MARK: - LayoutBoundarySupplementaryItem

    public var layoutBoundarySupplementaryItem: LayoutBoundarySupplementaryItem {
        self
    }

    // MARK: - ResizableItem

    /// Configure the width of the boundary supplementary item
    ///
    /// The default value is `.fractionalWidth(1.0)`
    public func width(_ width: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.widthDimension = width }
    }

    /// Configure the height of the boundary supplementary item
    ///
    /// The default value is `.fractionalHeight(1.0)`
    public func height(_ height: NSCollectionLayoutDimension) -> Self {
        with(self) { $0.heightDimension = height }
    }
}

extension BoundarySupplementaryItem: BuildableBoundarySupplementaryItem {
    func makeBoundarySupplementaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let boundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: widthDimension,
                heightDimension: heightDimension
            ),
            elementKind: elementKind,
            alignment: alignment,
            absoluteOffset: absoluteOffset
        )
        return boundarySupplementaryItem
    }
}
