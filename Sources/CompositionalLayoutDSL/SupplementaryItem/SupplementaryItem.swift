//
//  SupplementaryItem.swift
//  CompositionalLayoutDSL
//
//  Created by Alexandre Podlewski on 07/04/2021.
//  Copyright © 2021 Fabernovel. All rights reserved.
//

import UIKit

public struct SupplementaryItem: LayoutSupplementaryItem {

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

    public func containerAnchor(_ containerAnchor: NSCollectionLayoutAnchor) -> Self {
        with(self) { $0.containerAnchor = containerAnchor }
    }

    public func itemAnchor(_ itemAnchor: NSCollectionLayoutAnchor?) -> Self {
        with(self) { $0.itemAnchor = itemAnchor }
    }

    // TODO: (Alexandre Podlewski) 08/04/2021 Add other methods to ease LayoutAnchor creation ?

    // MARK: - LayoutSupplementaryItem

    public var layoutSupplementaryItem: CollectionLayoutSupplementaryItemConvertible {
        let size = NSCollectionLayoutSize(
            widthDimension: widthDimension,
            heightDimension: heightDimension
        )
        if let itemAnchor = itemAnchor {
            return NSCollectionLayoutSupplementaryItem(
                layoutSize: size,
                elementKind: elementKind,
                containerAnchor: containerAnchor,
                itemAnchor: itemAnchor
            )
        } else {
            return NSCollectionLayoutSupplementaryItem(
                layoutSize: size,
                elementKind: elementKind,
                containerAnchor: containerAnchor
            )
        }
    }
}
